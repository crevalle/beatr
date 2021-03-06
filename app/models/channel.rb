class Channel < ActiveRecord::Base

  has_many :beats

  scope :visible, -> { where public: true }
  scope :hidden,  -> { where public: false }

  before_destroy :remove_score!

  def self.fetch name
    return nil if name.blank?

    find_or_create_by name: name
  end

  def self.public_score_key; 'public_channel_scores'; end
  def self.private_score_key; 'private_channel_scores'; end

  def self.top_beats
    joins(:beats).select('channels.*, count(beats.id) as beats_count').group('channels.id').order('count(beats.id) desc')
  end

  # Channel.trending                    # => public, non-zero scores
  # Channel.trending private: true      # => private, non-zero scores
  # Channel.trending include_zero: true # => public, zero scores
  # Channel.trending limit: 5           # => public, limit 5 results
  #
  def self.trending options = {}
    key = options[:private] ? private_score_key : public_score_key
    limit = options.fetch :limit, -1
    min_score = options[:include_zero] ? '-inf' : 1

    opts = { with_scores: true, limit: [0, limit] }
    results = $redis.zrevrangebyscore(key, '+inf', min_score, opts).to_h # => { 'channel_name' => score.0 }

    if options[:channelize]
      results.inject({}) do |memo, (name, score)|
        memo[Channel.fetch(name)] = score.to_i
        memo
      end
    else
      results
    end
  end

  def self.subscriber_counts
    public_counts = trending.values.reduce(&:+) || 0
    private_counts = trending(private: true).values.reduce(&:+) || 0

    { public: public_counts,
      private: private_counts,
      total: public_counts + private_counts }
  end

  def private!
    # score will end up in wrong list if AR save fails
    return true if private?
    move_to_private_list
    self.public = false
    save
  end

  def public!
    return true if public?
    # score will end up in wrong list if AR save fails
    move_to_public_list
    self.public = true
    save
  end

  def move_to_private_list
    $redis.multi do
      count = subscriber_count
      remove_score!
      $redis.zadd self.class.private_score_key, count, name
    end
  end

  def move_to_public_list
    $redis.multi do
      count = subscriber_count
      remove_score!
      $redis.zadd self.class.public_score_key, count, name
    end
  end

  def remove_score!
    $redis.zrem scores_set_key, name
  end

  def add_subscriber!
    raise "can't modify subscribers without a name!" if name.blank?
    $redis.zincrby(scores_set_key, 1, name).tap do |count|
      Rails.logger.info "[#{Time.now.utc}] total subscribers #{count}"
    end
  end

  def remove_subscriber!
    raise "can't modify subscribers without a name!" if name.blank?
    $redis.zincrby(scores_set_key, -1, name).tap do |count|
      Rails.logger.info "[#{Time.now.utc}] total subscribers #{count}"
    end
  end

  def subscriber_count
    raise "can't modify subscribers without a name!" if name.blank?
    $redis.zscore(scores_set_key, name).to_i # will coerce nil into 0
  end

  def recent_beats_count
    beats.in_last(1.hour).count
  end

  def last_beat_at
    last_beat.try :created_at
  end

  def last_beat
    beats.rev_cron.first
  end

  def private?
    !public?
  end


  private

  def scores_set_key
    public? ? self.class.public_score_key : self.class.private_score_key
  end

end


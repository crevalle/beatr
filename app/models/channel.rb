class Channel < ActiveRecord::Base

  has_many :beats

  scope :visible, -> { where public: true }
  scope :trending, -> { with_subscribers.order subscriber_count: :desc }
  scope :with_subscribers, -> { where.not subscriber_count: 0 }

  def self.fetch name
    return nil unless name.present?

    find_or_create_by name: name
  end

  def self.global_count_key; 'global_subscriber_count'; end

  def self.global_subscriber_count
    SubscriberCount.get global_count_key
  end

  def add_subscriber!
    Rails.logger.warn "global count: #{increment_global_count}"
    SubscriberCount.incr channel_count_key
  end

  def remove_subscriber!
    puts 'removing subscriber'
    Rails.logger.warn "global count: #{decrement_global_count}"
    SubscriberCount.decr channel_count_key
  end

  def subscriber_count
    SubscriberCount.get channel_count_key
  end

  def recent_beats_count
    beats.in_last(1.hour).count
  end


  private

  def channel_count_key
    raise "can't get key without a channel name" if name.blank?
    "channel_#{name}_subscriber_count"
  end

  def global_count_key
    self.class.global_count_key
  end

  def increment_global_count
    SubscriberCount.incr global_count_key
  end

  def decrement_global_count
    SubscriberCount.decr global_count_key
  end
end


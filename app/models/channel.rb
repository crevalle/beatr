class Channel < ActiveRecord::Base

  has_many :beats

  scope :visible, -> { where public: true }
  scope :trending, -> { with_subscribers.order subscriber_count: :desc }
  scope :with_subscribers, -> { where.not subscriber_count: 0 }

  def self.fetch name
    return nil unless name.present?

    find_or_create_by name: name
  end

  def add_subscriber!
    self.subscriber_count += 1
    save
  end

  def remove_subscriber!
    self.subscriber_count -= 1
    save
  end

  def recent_beats_count
    beats.in_last(1.hour).count
  end

end


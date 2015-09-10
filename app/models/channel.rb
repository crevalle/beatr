class Channel < ActiveRecord::Base

  has_many :beats

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

end


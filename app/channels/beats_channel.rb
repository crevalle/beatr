class BeatsChannel < ApplicationCable::Channel
  def subscribed
    current_channel.add_subscriber!
    stream_from topic_name
    Broadcast.new(topic_name).update_count
    Rails.logger.info "subscribed to #{description}"
  end

  def unsubscribed
    current_channel.remove_subscriber!
    Broadcast.new(topic_name).update_count
    Rails.logger.info "unsubscribed from #{description}"
  end
end


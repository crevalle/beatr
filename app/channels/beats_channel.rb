class BeatsChannel < ApplicationCable::Channel
  def subscribed
    puts "subscribed to #{description}"
    current_channel.add_subscriber!
    stream_from topic_name
    Broadcast.new(topic_name).update_count
  end

  def unsubscribed
    current_channel.remove_subscriber!
    Broadcast.new(topic_name).update_count
    puts "unsubscribed from #{description}"
  end
end


class BeatsChannel < ApplicationCable::Channel
  def subscribed
    current_channel.add_subscriber!
    puts "subscribed to #{description}"
    stream_from topic_name
    Broadcast.new(topic_name).update_count
  end

  def unsubscribed
    current_channel.remove_subscriber!
    Broadcast.new(topic_name).update_count
    puts "unsubscribed from #{description}"
  end
end


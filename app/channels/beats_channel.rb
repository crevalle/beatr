class BeatsChannel < ApplicationCable::Channel
  def subscribed
    puts "subscribed to #{params.inspect}"
    stream_from params[:topic]
  end

  def unsubscribed
    puts "unsubscribed to #{params.inspect}"
  end
end


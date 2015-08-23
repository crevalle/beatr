class BeatsChannel < ApplicationCable::Channel
  def subscribed
  end

  def follow data
    stream_from data['topic']
  end
end

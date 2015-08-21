class BeatsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'beats'
  end
end

class BeatsChannel < ApplicationCable::Channel
  def subscribed
    # name = params[:id].gsub(' ', '-')
    # puts "streaming from #{name}"
    # puts params[:id]
    # stream_from 'beats'
  end

  def follow data
    stream_from data['topic']
  end
end

class BeatsController < ApplicationController

  def show
    @beat_name = params[:id]
  end

  def create
    channel = params[:id]
    WebsocketRails[channel].trigger(:heartbeat, { socks: 'pants' })
    render text: 'got it'
  end
end


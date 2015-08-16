class HomeController < ApplicationController

  def listen
    render 'show'
  end

  def create
    channel = params[:id]
    WebsocketRails[channel].trigger(:heartbeat, { socks: 'pants' })
    render text: 'got it'
  end

end

class HomeController < ApplicationController

  def show

  end

  def socks
    channel = params[:id]
    WebsocketRails[channel].trigger(:heartbeat, { socks: 'pants' })
    render text: 'got it'
  end

end

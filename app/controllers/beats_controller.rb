class BeatsController < ApplicationController

  def show
    @beat_name = params[:id]
  end

  def create
    channel = params[:id]
    @beat = Beat.create name: channel, ip: request.remote_ip

    WebsocketRails[channel].trigger(:heartbeat, { socks: 'pants' })
    render json: @beat
  end
end


class BeatsController < ApplicationController

  def show
    @beat_name = params[:id]
  end

  def create
    name = params[:id]

    channel = WebsocketRails[name]
    channel.trigger(:heartbeat, { socks: 'pants' })

    @beat = Beat.create name: name, ip: request.remote_ip, subscriber_count: channel.subscribers.count

    render json: { message: 'ok' }
  end
end


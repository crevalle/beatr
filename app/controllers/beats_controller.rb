class BeatsController < ApplicationController

  def show
    @beat_name = params[:id]
  end

  def create
    name = params[:id].gsub(' ', '-')

    b = ActionCable.server.broadcast 'beats', message: ''

    puts '*' * 20
    puts b.inspect

    # channel = WebsocketRails[name]
    # channel.trigger(:heartbeat, { socks: 'pants' })

    # @beat = Beat.create name: name, ip: request.remote_ip, subscriber_count: channel.subscribers.count

    head :ok
  end
end


class BeatsController < ApplicationController

  def show
    @beat_name = params[:id]
  end

  def create
    name = params[:id].gsub(' ', '-')

    subscriber_count = ActionCable.server.broadcast name, message: ''
    @beat = Beat.create name: name, ip: request.remote_ip, subscriber_count: subscriber_count

    head :ok
  end
end


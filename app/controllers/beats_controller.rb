class BeatsController < ApplicationController

  def show
    @beat_name = params[:id]
  end

  def create
    name = params[:id].gsub(' ', '-')

    b = ActionCable.server.broadcast name, message: ''

    # @beat = Beat.create name: name, ip: request.remote_ip, subscriber_count: channel.subscribers.count

    head :ok
  end


  def define_channel name
    klass_name = "#{name.capitalize}Channel"
    ActionCable.server.add_channel_class klass_name
  end
end


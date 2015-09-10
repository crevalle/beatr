class BeatsController < ApplicationController

  def show
    @beat_name = params[:id]
  end

  def create
    name = params[:id].gsub(' ', '-')
    Broadcast.new(name.downcase).beat request.remote_ip
    head :ok
  end
end


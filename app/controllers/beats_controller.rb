class BeatsController < ApplicationController

  def show
    @beat_name = params[:id]
    @channel = Channel.find_or_create_by name: @beat_name
  end

  def create
    Broadcast.new(sanitized_name).beat request.remote_ip
    head :ok
  end


  private

  def sanitized_name
    name = params[:id].gsub(' ', '-')
    name.downcase
  end
end


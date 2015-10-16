class BeatsController < ApplicationController

  before_filter :admin_auth, only: :dashboard

  def show
    @beat_name = params[:id]
    @channel = Channel.find_or_create_by name: @beat_name
  end

  def dashboard
    @counts = Channel.subscriber_counts
    @public_trending = Channel.trending channelize: true
    @private_trending = Channel.trending private: true, channelize: true

    @public_beats = Channel.visible.top_beats
    @private_beats = Channel.hidden.top_beats
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


class HomeController < ApplicationController

  def index
    # @trending = Channel.visible.trending.limit(5)
    @trending = []
  end

  def hot
    if params[:beat].present?
      redirect_to beats_path params[:beat]
    else
      render 'index'
    end
  end
end


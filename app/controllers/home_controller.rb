class HomeController < ApplicationController

  def index
    @trending = Channel.trending.limit(5)
  end

  def hot
    if params[:beat].present?
      redirect_to beats_path params[:beat]
    else
      render 'index'
    end
  end
end


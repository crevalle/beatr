class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_filter :set_websocket_url


  private

  def set_websocket_url
    gon.websocket_url = Rails.env.production? ? 'ws://ws.beatr.io' : 'ws://localhost:3013'
  end
end

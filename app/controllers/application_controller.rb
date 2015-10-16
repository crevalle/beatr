class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_filter :set_websocket_url


  private

  def admin_auth
    access_password = 'holysmokes'

    message = 'sorry bub'
    authenticate_or_request_with_http_basic message do |username, password|
      password == access_password
    end
  end

  def set_websocket_url
    gon.websocket_url = Rails.env.production? ? 'ws://ws.beatr.io' : 'ws://localhost:3013'
  end
end

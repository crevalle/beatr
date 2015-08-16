class BeatsController < WebsocketRails::BaseController

  def initialize_session
    controller_store[:message_count] = 0
  end

end

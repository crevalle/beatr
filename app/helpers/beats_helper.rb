module BeatsHelper

  # when a user loads a beat page, the websocket connection hasn't completed
  # and properly incremented the count.  So if they're the first connection,
  # the count will erroneously show zero instead of 1.  This doesn't apply
  # if you're a later connection, I think...
  def handle_websocket_connection_delay count
    count.to_i.zero? ? 1 : count
  end
end


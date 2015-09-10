class Broadcast

  def self.to channel, from = nil
    count = ActionCable.server.broadcast channel, message: ''

    ActionCable.server.broadcast 'admin', message: { channel: channel, subscribers: { count: count } } unless channel == 'admin'

    Beat.create name: name, ip: from, subscriber_count: count
  end
end

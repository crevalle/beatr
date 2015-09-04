class Broadcast

  def self.to channel, from = nil
    count = ActionCable.server.broadcast channel, message: ''

    beat = Beat.create name: name, ip: from, subscriber_count: count

    ActionCable.server.broadcast 'admin', message: { channel: channel, subscribers: { count: count } }

    beat
  end
end

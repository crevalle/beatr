class Broadcast

  def self.to channel, from = nil
    subscriber_count = ActionCable.server.broadcast channel, message: ''

    beat = Beat.create name: name, ip: from, subscriber_count: subscriber_count

    ActionCable.server.broadcast 'admin', message: { channel: channel }

    beat
  end
end

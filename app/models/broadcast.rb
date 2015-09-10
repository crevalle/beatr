class Broadcast

  def initialize name
    @name = name
  end

  def beat from = nil
    Beat.create channel: channel, ip: from

    payload = { channel: @name, type: 'beat', subscribers: { count: channel.subscriber_count } }

    broadcast @name, payload
    broadcast 'admin', payload unless @name == 'admin'
  end

  def update_count
    payload = { channel: @name, type: 'count', subscribers: { count: channel.subscriber_count } }
    broadcast @name, payload
  end


  private

  def broadcast topic, message
    ActionCable.server.broadcast topic, message
  end

  def channel
    @channel ||= Channel.fetch @name
  end
end


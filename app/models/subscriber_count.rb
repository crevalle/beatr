class SubscriberCount

  attr_reader :key

  def self.incr key
    new(key).increment
  end

  def self.decr key
    new(key).decrement
  end

  def self.get key
    new(key).get
  end

  def initialize key
    @key = key
  end

  def get
    $redis.get key or 0
  end

  def increment
    $redis.incr key
  end

  def decrement
    $redis.decr key
  end
end


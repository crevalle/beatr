ActionCable::Server::Base.config.logger = Rails.logger

# class ActionCable::Connection::Subscriptions

  # def add(data)
    # id_key = data['identifier']
    # id_options = ActiveSupport::JSON.decode(id_key).with_indifferent_access

    # subscription_klass = connection.server.channel_classes.fetch(id_options[:channel]) do |key|
      # connection.server.add_channel_class key
    # end

    # puts "subscription klass: #{subscription_klass}"
    # puts "curretn classes: #{connection.server.channel_classes}"

    # if subscription_klass
      # puts "subscriptions: #{subscriptions}"
      # kk = subscription_klass.new(connection, id_key, id_options)
      # binding.pry
      # subscriptions[id_key] ||= kk
    # else
      # logger.error "Subscription class not found (#{data.inspect})"
    # end
    # puts "done"
  # end
# end

# class ActionCable::Server::Base

  # def add_channel_class name
    # puts "adding class #{name}"
    # channel_class = define_channel name
    # channel_classes[name] = channel_class
    # channel_class
  # end

  # def define_channel name
    # klass_name = name.capitalize

    # if defined? klass_name.constantize == 'constant'
      # return klass_name.constantize
    # end

    # puts "defining #{klass_name}"

    # klass = Object.const_set klass_name, Class.new(ApplicationCable::Channel)
    # puts "have class #{klass}"
    # klass.class_eval "def subscribed; stream_from #{name}; end"
    # klass
  # end
# end


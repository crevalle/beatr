module ApplicationCable
  class Channel < ActionCable::Channel::Base

    def description
      "#{params[:channel]}:#{topic_name} (#{current_channel.subscriber_count})"
    end

    def topic_name
      params[:topic].downcase
    end

    def current_channel
      @current_channel ||= ::Channel.fetch topic_name
    end
  end
end


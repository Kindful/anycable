# frozen_string_literal: true

require "redis"
require "json"

module AnyCable
  # PubSub for broadcasting
  class PubSub
    attr_reader :redis_conn

    def initialize
      AnyCable.to_client
    end

    def broadcast(channel, payload)
      AnyCable.to_client.write({ stream: channel, data: payload }.to_json)
    end
  end
end

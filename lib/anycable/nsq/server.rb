# frozen_string_literal: true

require 'anycable/nsq/handler'

module AnyCable
  module NSQ
    # Wrapper over GRPC server
    module Server
      class << self
        @running = true
        def start
          log_grpc! if AnyCable.config.log_grpc

          rpc = AnyCable::NSQ::Handler.new
          loop do
            if msg = AnyCable.from_client.pop_without_blocking
              begin
                rpc.handle(msg.body)
                msg.finish
                sleep 0.001
              rescue StandardError
                if msg.attempts < 5
                  msg.requeue(5 * 1000)
                else
                  msg.finish
                end
              end
            else
              # wait for a bit before checking for new messages
              sleep 0.01
            end
          end
        end

        def stop
          # return unless running?

          # @grpc_server.stop
        end

        def running?
          # grpc_server&.running_state == :running
        end

        def log_grpc!
        end
      end
    end
  end
end

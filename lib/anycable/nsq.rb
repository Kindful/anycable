module AnyCable
  module NSQ
  end
end

require "anycable/nsq/server"

# GRPC example

# AnyCable.server_builder = ->(config) {
#   AnyCable.logger.info "gRPC version: #{::GRPC::VERSION}"

#   ::GRPC.define_singleton_method(:logger) { AnyCable.logger } if config.log_grpc?

#   params = config.to_grpc_params

#   AnyCable::GRPC::Server.new(**params, host: config.rpc_host)
# }

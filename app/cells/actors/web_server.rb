require 'celluloid/current'
require 'reel'
require_relative '../../config/router'

module Actors
  class WebServer < Reel::Server::HTTP
    include Celluloid::Internals::Logger

    def initialize(host = '0.0.0.0', port = ENV['PORT'] || 3000)
      info "WebServer starting on #{host}:#{port}"
      super(host, port, &method(:on_connection))
    end

    def on_connection(connection)
      while request = connection.request
        if request.websocket?
          info 'Received a WebSocket connection'
          connection.detach

          route_websocket request.websocket
          return
        else
          info 'Received a HTTP connection'
          Router::request connection, request
        end
      end
    end

    def route_websocket(socket)
      if socket.url == "/ws"
        Actors::Writer.new(socket)
      else
        info "Received invalid WebSocket request for: #{socket.url}"
        socket.close
      end
    end
  end
end

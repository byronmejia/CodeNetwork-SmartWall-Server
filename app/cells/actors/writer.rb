require 'json'
require 'celluloid/current'

module Actors
  class Writer
    include Celluloid
    include Celluloid::Notifications
    include Celluloid::Internals::Logger

    def initialize(websocket)
      info 'Writing to new socket client'
      @socket = websocket
      subscribe 'webSocket', :new_message
    end

    def new_message(topic, message)
      @socket << message.to_json
    rescue Reel::SocketError
      info 'WS Client disconnected'
      terminate
    end
  end
end

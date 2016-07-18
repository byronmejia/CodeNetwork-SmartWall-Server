require 'celluloid/current'

module Actors
  class Writer
    include Celluloid
    include Celluloid::Notifications
    include Celluloid::Internals::Logger

    def initialize(websocket)
      info 'Writing to new socket client'
      @socket = websocket
      subscribe('write_message', :new_message)
    end

    def new_message(topic, message)
      @socket << message.inspect
    rescue Reel::SocketError
      info 'WS client disconnected'
      terminate
    end
  end
end

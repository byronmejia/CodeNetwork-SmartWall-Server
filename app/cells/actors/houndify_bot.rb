require 'celluloid/current'

module Actors
  class HoundifyBot
    include Celluloid
    include Celluloid::Notifications
    include Celluloid::Internals::Logger

    def initialize
      now = Time.now.to_f
      sleep now.ceil - now + 0.001
      info 'TwitterFilter: Listening on user feed'
      subscribe 'houndWorker', :new_message
    end
  end
end

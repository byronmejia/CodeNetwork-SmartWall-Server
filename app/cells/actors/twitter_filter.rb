require 'celluloid/current'

module Actors
  class TwitterFilter
    include Celluloid
    include Celluloid::Notifications
    include Celluloid::Internals::Logger

    def initialize
      now = Time.now.to_f
      sleep now.ceil - now + 0.001

      info 'TwitterFilter: Listening on user feed'

      subscribe 'twitter-filter', :new_message
    end

    def new_message(topic, message)
      # Check for profanities
      return nil if profanity_check message.text
      return nil if profanity_check message.user.screen_name

      # Check type of message
      type = type_check message

      final_object = type_check(message)

      # Pipe it straight
      case type
        when 0
          # Pipe to Houndify Worker
          # Pipe to Websocket Writer
          publish 'webSocket', final_object
          publish 'houndWorker', final_object
        when 1
          # Pipe only to websocket
          publish 'webSocket', final_object
      end
    end

    def profanity_check(text)
      # if Profanity, drop pipeline
      # else Continue to pipe it

      0
    end

    def type_check(message)
      # if one type, return a number
      # else return another

      0
    end

    def object_creator(message)

      message
    end
  end
end

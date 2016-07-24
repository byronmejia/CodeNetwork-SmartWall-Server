require 'twitter'
require 'celluloid/current'

module Actors
  class TwitterBot
    include Celluloid
    include Celluloid::Notifications
    include Celluloid::Internals::Logger
    attr_reader :twitter_client

    def initialize(setting = 0)
      now = Time.now.to_f
      sleep now.ceil - now + 0.001

      @twitter_client = Twitter::Streaming::Client.new do |config|
        config.consumer_key = ENV['TW_CON_PUB']
        config.consumer_secret = ENV['TW_CON_KEY']
        config.access_token = ENV['TW_ACC_PUB']
        config.access_token_secret = ENV['TW_ACC_KEY']
      end

      info 'TwitterBot: Listening on user feed'

      case(setting)
        when 1
          async.listen
        else
          info 'WARNING: Doing Nothing... Zombie Thread Spawning'
          terminate
      end
    end

    def listen
      info 'TwitterStream: Publishing user topics.'
      @twitter_client.user do |object|
        case object
          when Twitter::Tweet
            info "TwitterBot: #{object.user.screen_name}: #{object.text}"
            # Pipe it straight away
            publish 'twitter-filter', object
          when Twitter::Streaming::StallWarning
            info "TwitterBot: Warning -- #{object.to_json}"
            publish 'twitter-warnings', object
        end
      end
    end
  end
end

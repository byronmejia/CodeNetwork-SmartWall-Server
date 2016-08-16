class TwitterListener
  include Celluloid
  include Celluloid::Internals::Logger
  attr_reader :twitter_client
  attr_reader :redis
  attr_reader :publish_channel
  attr_reader :worker_channel
  attr_reader :id

  def initialize(setting = 0)
    now = Time.now.to_f
    sleep now.ceil - now + 0.001

    @worker_channel = ENV['RD_WORKER_CHANNEL']
    @publish_channel = ENV['RD_PUBLISH_CHANNEL']
    @id = SecureRandom.uuid
    @twitter_client = Twitter::Streaming::Client.new do |config|
      config.consumer_key = ENV['TW_CON_PUB']
      config.consumer_secret = ENV['TW_CON_KEY']
      config.access_token = ENV['TW_ACC_PUB']
      config.access_token_secret = ENV['TW_ACC_KEY']
    end

    @redis = Redis.new
    @redis.publish(
        @worker_channel,
        {
            :id => @id
        }.to_json
    )

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
          @redis.publish(@publish_channel, object.to_json)
        when Twitter::Streaming::StallWarning
          info "TwitterBot: Warning -- #{object.to_json}"
      end
    end
  end
end
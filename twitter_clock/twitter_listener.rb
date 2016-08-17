class TwitterListener
  include Celluloid
  include Celluloid::Internals::Logger
  attr_reader :twitter_client
  attr_reader :redis
  attr_reader :publish_channel
  attr_reader :worker_channel
  attr_reader :question_channel
  attr_reader :id

  def initialize(setting = 0)
    now = Time.now.to_f
    sleep now.ceil - now + 0.001

    @worker_channel = ENV['RD_WORKER_CHANNEL']
    @publish_channel = ENV['RD_PUBLISH_CHANNEL']
    @question_channel = ENV['RD_QUESTION_CHANNEL']
    @id = SecureRandom.uuid
    @twitter_client = Twitter::Streaming::Client.new do |config|
      config.consumer_key = ENV['TW_CON_PUB']
      config.consumer_secret = ENV['TW_CON_KEY']
      config.access_token = ENV['TW_ACC_PUB']
      config.access_token_secret = ENV['TW_ACC_KEY']
    end

    @redis = Redis.new(
        :url => ENV['REDIS_URL'] || nil
    )
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
      when 2
        async.listen_user
      else
        info 'WARNING: Doing Nothing... Zombie Thread Spawning'
        terminate
    end
  end

  def listen
    topics = %w(NatSciWk NatSciWkSW)
    info "TwitterStream: Publishing: #{topics.to_s}"
    @twitter_client.filter(track: topics.join(',')) do |object|
      case object
        when Twitter::Tweet
          info "TwitterBot: #{object.user.screen_name}: #{object.text}"
          question = false
          object.hashtags.each do |p|
            if p.text.to_s.downcase == 'natsciwksw'
              info 'Question!'
              question = true
            end
          end
          # Pipe it straight away
          if question
            @redis.publish(
                @question_channel,
                {
                    :name => object.user.name,
                    :username => object.user.screen_name,
                    :profile_image => object.user.profile_image_url.to_s,
                    :fav_colour => object.user.profile_background_color,
                    :tweet => object.text,
                    :id => object.id
                }.to_json
            )
          end
          @redis.publish(
              @publish_channel,
              {
                  :name => object.user.name,
                  :username => object.user.screen_name,
                  :profile_image => object.user.profile_image_url.to_s,
                  :fav_colour => object.user.profile_background_color,
                  :tweet => object.text
              }.to_json
          )
        when Twitter::Streaming::StallWarning
          info "TwitterBot: Warning -- #{object.to_json}"
      end
    end
  end
end
class HoundPublisher
  include Celluloid
  include Celluloid::Internals::Logger
  include Celluloid::Notifications
  attr_reader :redis
  attr_reader :publish_channel

  def initialize
    info 'Ready to publish'
    subscribe 'hound-bot', :new_message
    @publish_channel = ENV['RD_PUBLISH_CHANNEL']
    @redis = Redis.new(
        :url => ENV['REDIS_URL'] || nil
    )
  end

  def new_message(topic, data)
    info 'Publishing...'
    @redis.publish(
        @publish_channel,
        {
            :type => 'lengthy',
            :response => data['AllResults'][0]['SpokenResponseLong']
        }.to_json
    )
  end
end

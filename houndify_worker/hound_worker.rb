class HoundWorker
  include Celluloid
  include Celluloid::Internals::Logger
  include Celluloid::Notifications
  attr_reader :twitter_client
  attr_reader :question_channel
  attr_reader :redis
  attr_reader :regex_hastag

  def initialize
    @regex_hastag = /#\w+/
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TW_CON_PUB']
      config.consumer_secret = ENV['TW_CON_KEY']
      config.access_token = ENV['TW_ACC_PUB']
      config.access_token_secret = ENV['TW_ACC_KEY']
    end
    @question_channel = ENV['RD_QUESTION_CHANNEL']
    @redis = Redis.new(
        :url => ENV['REDIS_URL'] || nil
    )
    info 'Hound Bot now listening on REDIS'
    async.listen
  end

  def listen
    @redis.subscribe(@question_channel) do |on|
      on.message do |channel, msg|
        data = JSON.parse(msg)
        respond_tweet(data['id'], data['username'], data['tweet'])
    end
    end
  end

  def ask_hound(user_id, query)
    query = query.gsub(@regex_hastag, '')
    info query
    client = Houndify::Client.new(user_id)
    response = client.request(query)
    info response
    publish 'hound-bot', response
    response['AllResults'][0]['SpokenResponseLong']
  end

  def respond_tweet(tweet_id, user_id, query)
    info 'Responding!'
    response = ask_hound(user_id, query)
    tweet = "@#{user_id} #{response[0, 100]}- #NatSciWk"
    info "#{tweet}"
    @twitter_client.update(
        tweet,
        in_reply_to_status_id: tweet_id
    )
  end
end
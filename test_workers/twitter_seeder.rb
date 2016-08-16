require 'redis'
require 'securerandom'
require 'json'
require 'timers'

CONFIG_FILE = File.join(__dir__, '..', 'config', 'secrets.json')
if File.file?(CONFIG_FILE)
  SECRETS = JSON.parse(
      File.read(
          CONFIG_FILE
      )
  )
  ENV['RD_WORKER_CHANNEL'] = SECRETS['REDIS']['CHANNEL']['WORKER']
  ENV['RD_PUBLISH_CHANNEL'] = SECRETS['REDIS']['CHANNEL']['PUBLISH']
end

Words = JSON.parse(
    File.read(
        File.join(
            __dir__, 'words.json'
        )
    )
)

Quotes = JSON.parse(
    File.read(
        File.join(
            __dir__, 'quotes.json'
        )
    )
)

def random_name(adjective, noun)
  "#{adjective.sample}#{noun.sample}"
end

worker_channel = ENV['RD_WORKER_CHANNEL']
publish_channel = ENV['RD_PUBLISH_CHANNEL']
id = SecureRandom.uuid

redis = Redis.new(
    :url => ENV['REDIS_URL'] || nil
)
redis.publish(
    worker_channel,
    {
        :id => id
    }.to_json
)

loop do
  payload = {
      :name => random_name(Words['ADJECTIVE'], Words['NOUN']),
      :tweet => Quotes['QUOTES'].sample
  }
  redis.publish(
      publish_channel,
      payload.to_json
  )
  puts "Published: #{payload[:name]} - #{payload[:tweet]}"
  sleep 5
end
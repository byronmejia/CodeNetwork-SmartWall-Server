require 'rack'
require 'faye/websocket'
require 'redis'
require 'json'
require 'celluloid/current'

CONFIG_FILE = File.join(__dir__, '..', 'config', 'secrets.json')
if File.file?(CONFIG_FILE)
  SECRETS = JSON.parse(
      File.read(
          CONFIG_FILE
      )
  )
  ENV['RD_PUBLISH_CHANNEL'] = SECRETS['REDIS']['CHANNEL']['PUBLISH']
end

class ClientCollection
  include Celluloid
  include Celluloid::Notifications
  include Celluloid::Internals::Logger
  attr_reader :clients
  def initialize
    now = Time.now.to_f
    sleep now.ceil - now + 0.001
    @clients = []
    subscribe 'client-fan-out', :message
  end

  def add(client)
    info "Adding: #{client}"
    @clients << client
  end

  def remove(client)
    info "Removing: #{client}"
    @clients.delete(client)
  end

  def message(topic, msg)
    info 'Broadcasting!'
    @clients.each do |ws|
      ws.send(msg)
    end
  end
end

class RedisSubscriber
  include Celluloid
  include Celluloid::Notifications
  include Celluloid::Internals::Logger
  attr_reader :publish_channel
  attr_reader :redis
  def initialize
    now = Time.now.to_f
    sleep now.ceil - now + 0.001
    @publish_channel = ENV['RD_PUBLISH_CHANNEL']
    @redis = Redis.new(
        :url => ENV['REDIS_URL'] || nil
    )
    async.listen
  end

  def listen
    @redis.subscribe(@publish_channel) do |on|
      on.message do |channel, msg|
        data = JSON.parse(msg)
        info "##{channel} - #{msg}}"
        publish 'client-fan-out', msg
      end
    end
  end
end

redis_client = RedisSubscriber.new
client_collection = ClientCollection.new

WEB_SOCKET_SERVER = lambda do |env|
  if Faye::WebSocket.websocket?(env)
    ws = Faye::WebSocket.new(env)

    ws.on :open do |event|
      client_collection.add ws
    end

    ws.on :close do |event|
      client_collection.remove ws
    end

    ws.rack_response
  end
end

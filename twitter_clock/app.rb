require 'celluloid/current'
require 'json'
require 'securerandom'
require 'twitter'
require 'redis'
require_relative './twitter_listener'
require_relative './twitter_supervisor'

CONFIG_FILE = File.join(__dir__, '..', 'config', 'secrets.json')
if File.file?(CONFIG_FILE)
  SECRETS = JSON.parse(
      File.read(
          CONFIG_FILE
      )
  )
  ENV['TW_CON_PUB'] = SECRETS['TWITTER']['CONSUMER']['KEY']
  ENV['TW_CON_KEY'] = SECRETS['TWITTER']['CONSUMER']['SECRET']
  ENV['TW_ACC_PUB'] = SECRETS['TWITTER']['ACCESS']['TOKEN']
  ENV['TW_ACC_KEY'] = SECRETS['TWITTER']['ACCESS']['SECRET']
  ENV['RD_WORKER_CHANNEL'] = SECRETS['REDIS']['CHANNEL']['WORKER']
  ENV['RD_PUBLISH_CHANNEL'] = SECRETS['REDIS']['CHANNEL']['PUBLISH']
end


# Run Supervisors & Sleep
TwitterSupervisor.run!
sleep

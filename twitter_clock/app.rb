require 'celluloid/current'
require 'twitter'
require 'redis'
require_relative './twitter_listener'
require_relative './twitter_supervisor'

ENV['RACK_ENV'] = 'development' if ENV['RACK_ENV'].nil?

if ENV['RACK_ENV'] == 'development'
  SECRETS = JSON.parse(
      File.read(
          File.join(__dir__, '..', 'config', 'secrets.json')
      )
  )
  ENV['TW_CON_PUB'] = SECRETS['TWITTER']['CONSUMER']['KEY']
  ENV['TW_CON_KEY'] = SECRETS['TWITTER']['CONSUMER']['SECRET']
  ENV['TW_ACC_PUB'] = SECRETS['TWITTER']['ACCESS']['TOKEN']
  ENV['TW_ACC_KEY'] = SECRETS['TWITTER']['ACCESS']['SECRET']
end

# Run Supervisors & Sleep
TwitterSupervisor.run!
sleep

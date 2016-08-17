require 'celluloid/current'
require 'redis'
require 'twitter'

require_relative '../lib/houndify/houndify'
require_relative 'hound_worker'
require_relative 'hound_publisher'
require_relative 'hound_supervisor'


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
  ENV['HOUNDIFY_TOKEN'] = SECRETS['HOUNDIFY']['TOKEN']
  ENV['HOUNDIFY_SECRET'] = SECRETS['HOUNDIFY']['SECRET']
  ENV['RD_QUESTION_CHANNEL'] = SECRETS['REDIS']['CHANNEL']['QUESTION']
  ENV['RD_PUBLISH_CHANNEL'] = SECRETS['REDIS']['CHANNEL']['PUBLISH']
end

Houndify.set_secrets(ENV['HOUNDIFY_TOKEN'], ENV['HOUNDIFY_SECRET'])

HoundSupervisor.run!

sleep

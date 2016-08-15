require 'celluloid/current'
require 'reel'

# Configuration Methods
if ENV['RACK_ENV'].nil?
  SECRETS = JSON.parse(
      File.read(
          File.join(__dir__, 'config', 'secrets.json')
      )
  )
  ENV['TW_CON_PUB'] = SECRETS['TWITTER']['CONSUMER']['KEY']
  ENV['TW_CON_KEY'] = SECRETS['TWITTER']['CONSUMER']['SECRET']
  ENV['TW_ACC_PUB'] = SECRETS['TWITTER']['ACCESS']['TOKEN']
  ENV['TW_ACC_KEY'] = SECRETS['TWITTER']['ACCESS']['SECRET']
end
ENV['RACK_ENV'] = ENV['RACK_ENV'] || 'development'

# ---- Load The Database -----
@path = File.dirname(__FILE__)

# ---- Load Supervisors ------
require_relative 'cells/supervisors/web_server'
require_relative 'cells/supervisors/twitter_visors'

Supervisors::WebServer.run!
Supervisors::TwitterVisor.run!

sleep
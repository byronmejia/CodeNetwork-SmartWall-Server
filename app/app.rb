require 'celluloid/current'
require 'reel'
require 'mongoid'

# Configuration Methods
SECRETS = JSON.parse(File.read('config/secrets.json'))
ENV['TW_CON_PUB'] = SECRETS['TWITTER']['CONSUMER']['KEY']
ENV['TW_CON_KEY'] = SECRETS['TWITTER']['CONSUMER']['SECRET']
ENV['TW_ACC_PUB'] = SECRETS['TWITTER']['ACCESS']['TOKEN']
ENV['TW_ACC_KEY'] = SECRETS['TWITTER']['ACCESS']['SECRET']
ENV['MONGO_URI'] = SECRETS['MONGO_URI']
ENV['RACK_ENV'] = ENV['RACK_ENV'] || 'development'

# ---- Load The Database -----
@path = File.dirname(__FILE__)
@mongoid_path = @path + '/config/mongoid.yml'
Mongoid.load!(@mongoid_path, ENV['RACK_ENV'])

require_relative 'models/_init'

# ---- Load Supervisors ------
require_relative 'cells/supervisors/web_server'
require_relative 'cells/supervisors/twitter_visors'

Supervisors::WebServer.run!
Supervisors::TwitterVisor.run!

sleep
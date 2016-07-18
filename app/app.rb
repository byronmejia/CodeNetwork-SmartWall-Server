# ------ Concurrency ---------
require 'celluloid/current'
require 'reel'

# ---- Load Supervisors ------
require_relative 'cells/supervisors/web_server'
require_relative 'cells/supervisors/twitter_visors'

# Configuration Methods
SECRETS = JSON.parse(File.read('config/secrets.json'))
ENV['TW_CON_PUB'] = SECRETS['TWITTER']['CONSUMER']['KEY']
ENV['TW_CON_KEY'] = SECRETS['TWITTER']['CONSUMER']['SECRET']
ENV['TW_ACC_PUB'] = SECRETS['TWITTER']['ACCESS']['TOKEN']
ENV['TW_ACC_KEY'] = SECRETS['TWITTER']['ACCESS']['SECRET']

Supervisors::WebServer.run!
Supervisors::TwitterVisor.run!

sleep
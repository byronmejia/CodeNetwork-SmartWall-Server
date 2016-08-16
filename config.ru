require 'sprockets'
require 'v8'
require 'uglifier'

require_relative './ws/app'
require_relative './http/app'

Faye::WebSocket.load_adapter 'puma'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'sprockets/javascripts'
  environment.js_compressor  = :uglify
  run environment
end

map '/ws' do
  run WEB_SOCKET_SERVER
end

map '/' do
  run HttpApp
end

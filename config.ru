require 'sprockets'
require 'v8'
require 'uglifier'
require 'sass'

require_relative './ws/app'
require_relative './http/app'

Faye::WebSocket.load_adapter 'puma'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'sprockets/javascripts'
  environment.append_path 'sprockets/stylesheets'
  environment.append_path 'sprockets/vendor'
  environment.js_compressor  = :uglify
  environment.css_compressor = :scss
  run environment
end

map '/ws' do
  run WEB_SOCKET_SERVER
end

map '/' do
  run HttpApp
end

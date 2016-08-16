require_relative './ws/app'
require_relative './http/app'

Faye::WebSocket.load_adapter 'puma'

map '/ws' do
  run WEB_SOCKET_SERVER
end

map '/' do
  run HttpApp
end

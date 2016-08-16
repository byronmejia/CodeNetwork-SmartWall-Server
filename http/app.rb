require 'sinatra'

class HttpApp < Sinatra::Application
  get '/' do
    'Hello World'
  end
end

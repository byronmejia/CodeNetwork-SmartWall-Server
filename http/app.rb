require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'

# Helper Function for Importing Directories
def require_folder(string)
  Dir[__dir__ + "/#{string}/**/*.rb"].each do |file|
    require file
  end
end

class HttpApp < Sinatra::Application
  configure do
    set :slim, :layout => :'_layouts/_default'
  end
end

require_folder 'routes'

class HttpApp < Sinatra::Application
  get '/' do
    slim :'index'
  end
end

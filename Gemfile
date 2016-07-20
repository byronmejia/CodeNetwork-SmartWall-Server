# -------- Rubies Ver --------
source 'https://rubygems.org'
# Use Jruby as our engine, and specify to RVM what we are using
# see RVM for more details
#ruby=jruby-9.0.5.0
#ruby-gemset=SmartWallServer
ruby '2.2.3', engine: 'jruby', engine_version: '9.0.5.0'

# ------ Concurrency ---------
gem 'celluloid'
gem 'reel'

# ----- The Twitters ---------
gem 'twitter'

# ---- Not Relational --------
gem 'mongoid'

# ----- Authenticate ---------
gem 'bcrypt'
gem 'jwt'

=begin
# ----- Web of things --------
# This is done as authentication
# Over WebSocket is not good
gem 'sinatra'
gem 'puma'
=end

=begin
# ----- Persistence ----------
gem 'mongoid'

# ----- Authentication ---------
gem 'bcrypt'
gem 'warden'
=end

# ------ Console I/O ---------
group :development do
  gem 'travis'
end

# ----- Test & Q.A. ----------
group :test do
  gem 'rspec', require: 'spec'
  gem 'rack-test'
  gem 'rubocop', '~> 0.38.0', require: false
end

# ------- Documentation ------
group :doc do
  gem 'yard'
end

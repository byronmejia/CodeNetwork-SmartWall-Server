# -------- Rubies Ver --------
source 'https://rubygems.org'
# Use RBX as our engine, and specify to RVM what we are using
# see RVM for more details
#ruby=jruby-9.1.2.0
#ruby-gemset=SmartWallServerJruby
ruby '2.3.0', engine: 'jruby', engine_version: '9.1.2.0'

# ------ Concurrency ---------
gem 'celluloid'
gem 'reel'

# ----- The Twitters ---------
gem 'twitter'

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

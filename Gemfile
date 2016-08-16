# -------- Rubies Ver --------
source 'https://rubygems.org'
# Use RBX as our engine, and specify to RVM what we are using
# see RVM for more details
#ruby=ruby-2.3.1
#ruby-gemset=SmartWallServer
ruby '2.3.1'

# -------- Rack Server -------
gem 'puma'

# -------- Web Server --------
gem 'sinatra'

# -------- Web Socket --------
gem 'faye'

# ------ Twitter Clock -------
gem 'celluloid'
gem 'twitter'

# ---- Distributed Coms ------
# -- And Key/Value Store
gem 'redis'

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

# -------- Rubies Ver --------
source 'https://rubygems.org'
# Use RBX as our engine, and specify to RVM what we are using
# see RVM for more details
#ruby=rbx-3.49
#ruby-gemset=SmartWallServerRbx
ruby '2.3.1', engine: 'rbx', engine_version: '3.49'

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

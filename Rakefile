# Signal catching
def shut_down
  puts "\nShutting down gracefully..."
end

# Trap ^C
Signal.trap('INT') {
  shut_down
  exit
}

# Trap `Kill `
Signal.trap('TERM') {
  shut_down
  exit
}

namespace :run do
  desc 'Run Twitter Clock'
  task :twitter do
    ruby File.join(__dir__, 'twitter_clock', 'app.rb')
  end
end

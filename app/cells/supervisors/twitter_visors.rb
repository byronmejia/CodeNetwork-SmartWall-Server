require 'celluloid/current'
require_relative '../actors/twitter_bot'

module Supervisors
  class TwitterVisor < Celluloid::Supervision::Container
    include Celluloid::Internals::Logger
    supervise type: Actors::TwitterBot, as: :twitter_bot, args: [1]

    def restart_actor(actor,reason)
      info "#{actor.inspect} actor died reason #{reason.class} #{reason.to_s}"
      info "#{actor.inspect} sleeping for 10 seconds"
      sleep(10)
      super
    end
  end
end
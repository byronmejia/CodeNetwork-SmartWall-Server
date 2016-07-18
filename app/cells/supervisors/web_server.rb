require 'celluloid/current'
require_relative '../actors/web_server'

module Supervisors
  class WebServer < Celluloid::Supervision::Container
    include Celluloid::Internals::Logger

    supervise type: Actors::WebServer, as: :reel

    def restart_actor(actor, reason)
      info "#{actor.inspect} actor died reason #{reason.class} #{reason.to_s}"
      info "#{actor.inspect} sleeping for 2 seconds"
      sleep(2)
      super
    end
  end
end

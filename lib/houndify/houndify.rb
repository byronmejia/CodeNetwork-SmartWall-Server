require 'openssl'

module Houndify
  mattr_reader :secrets
  def self.set_secrets(id, key)
    @secrets = {
        token: id,
        key: key
    }
  end

  class Client
    attr_reader :userID
    def initialize(userID)
      @userID = userID
    end

    def request(requestObject)
      puts requestObject
      puts 'Todo: make request'
    end

    private :generate_headers
    def generate_headers(requestID)
      raise 'No Client ID saved' if Houndify.secrets[:id].nil?
      raise 'No Client Key saveed' if Houndify.secrets[:key].nil?

      requestData = generate_request_auth(requestID)
      timeStamp = Time.now
    end

    private :generate_request_auth
    def generate_request_auth(requestID)
      "{#{@userID}}:{#{requestID}}"
    end
  end
end

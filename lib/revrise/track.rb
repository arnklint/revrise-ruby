require 'net/http'
require 'json'

module RevRise
  class Track < API
    def initialize( token )
      @endpoint = "http://api.revrise.com"
    end

  end
end

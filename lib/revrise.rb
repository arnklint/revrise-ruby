require "base64"
require "json"
require 'net/http'

require 'uri'

require "revrise/version"
require "revrise/api"
require "revrise/errors"

module RevRise
  class Base
    def initialize( token )
      @endpoint = "http://api.revrise.com/events/track?token=" + token
    end

    def track( event_name, properties )
      event = {
        :name => event_name,
        :properties => properties
      }.to_json

      data = Base64.encode64(event).gsub(/\n/, '')

      url = "#{@endpoint}&data=#{data}"
      uri = URI(url)

      http = Net::HTTP.new(uri.host, uri.port)
      size = 1000
      headers = {
        'Range' => "bytes=#{size}-"
      }

      response = begin
                   http.get(uri.to_s, headers)
                 rescue *HTTP_ERRORS => e
                   #log :error, "Unable to contact the RevRise server. HTTP Error=#{e}"
                   nil
                 end

      case response
      when Net::HTTPSuccess then
        #log :info, "Success: #{response.class}", response
      else
        #log :error, "Failure: #{response.class}", response
        puts "Unable to reach RevRise API. Check status"
      end
    end
  end
end

require "base64"
require "json"
require 'net/http'

require 'uri'

module RevRise
  class Client
    DEFAULT_OPTIONS = {
      host: 'revrise.com'
    }

    attr_accessor :options

    def initialize( options={} )
      #@endpoint = "http://api.revrise.com/events/track?token=" + token

      #raise ArgumentError, "Authentication token and email must be present" if !
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
                 rescue *HTTPError => e
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

    private

    def store_options(options={})
      @options ||= DEFAULT_OPTIONS.dup
      @options.merge!(options)
    end
  end

end

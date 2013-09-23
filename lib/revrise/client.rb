require "base64"
require "json"
require 'net/http'

require 'uri'

module RevRise
  class Client
    USER_AGENT      = "RevRise Ruby Wrapper #{VERSION}"
    API_SUBDOMAIN   = "api"

    DEFAULT_OPTIONS = {
      host: 'revrise.com'
    }

    attr_accessor :options

    def initialize( options={} )
      store(options)

      if authentication_token.nil? ||user_email.nil?
        raise ArgumentError, "Authentication token and email must be present" 
      end
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

    def authentication_token
      @options[:authentication_token]
    end

    def user_email
      @options[:user_email]
    end

    private

    def store(options={})
      @options ||= DEFAULT_OPTIONS.dup
      @options.merge!(options)
    end
  end

end

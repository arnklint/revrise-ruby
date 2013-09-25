require "base64"
require "json"
require 'net/http'

require 'uri'

module RevRise
  class Client
    include HTTParty

    USER_AGENT      = "RevRise Ruby Wrapper #{VERSION}"
    API_SUBDOMAIN   = "api"

    DEFAULT_OPTIONS = {
      host: 'revrise.com',
      use_ssl: true
    }

    headers({"User-Agent" => USER_AGENT})

    attr_accessor :options

    def initialize( options={} )
      store(options)

      if auth_token.nil? ||auth_email.nil?
        raise ArgumentError, "Authentication token and email must be present" 
      end
    end

    def get(path, query={}, options={})
      handle_response {
        self.class.get(*build_query(path, options.merge(:query => query)))
      }
    end

    def delete(path, query={}, options={})
      handle_response {
        self.class.delete(*build_query(path, options.merge(:query => query)))
      }
    end

    def head(path, query={}, options={})
      handle_response {
        self.class.head(*build_query(path, options.merge(:query => query)))
      }
    end

    def auth_token
      @options[:auth_token]
    end

    def auth_email
      @options[:auth_email]
    end

    def host
      @options[:host]
    end

    def use_ssl?
      @options[:use_ssl]
    end

    def api_host
      [API_SUBDOMAIN, host].join(".")
    end

    private

    def store(options={})
      @options ||= DEFAULT_OPTIONS.dup
      @options.merge!(options)
    end

    def handle_response(&block)
      response = block.call
      if response && !response.success?
        raise ResponseError.new(response)
      elsif response.is_a?(Hash)
        HashResponseWrapper.new(response)
      elsif response.is_a?(Array)
        ArrayResponseWrapper.new(response)
      elsif response && response.success?
        response
      end
    end

    def build_query(path_or_uri, options={}, body_or_query=:query)
      uri = URI.parse(path_or_uri)
      path = uri.path
      scheme = use_ssl? ? 'https' : 'http'
      options = options.dup
      options[body_or_query] ||= {}
      options[body_or_query][:format] = "json"
      options[body_or_query][:auth_token] = auth_token
      options[body_or_query][:auth_email] = auth_email

      ["#{scheme}://#{api_host}#{path}#{uri.query ? "?#{uri.query}" : ""}", options]

    end
  end
end

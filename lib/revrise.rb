require 'uri'

require 'httparty'
require 'hashie'

require "revrise/version"
require "revrise/client"
require "revrise/errors"
require "revrise/array_response_wrapper"
require "revrise/hash_response_wrapper"

module RevRise
  def new(options={})
    Client.new(options)
  end
  module_function :new

  def method_missing(method_name, *args, &block)
    return super unless respond_to_missing?(method_name)
    Client.send(method_name, *args, &block)
  end
  module_function :method_missing

  def respond_to_missing?(method_name, include_private=false)
    Client.respond_to?(method_name, include_private)
  end
  module_function :respond_to_missing?
end

Revrise = RevRise

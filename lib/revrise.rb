require 'uri'

require 'httparty'

require "revrise/client"
require "revrise/errors"
require "revrise/version"

module RevRise
  def new(options={})
    Client.new(options)
  end
  module_function :new
end

Revrise = RevRise

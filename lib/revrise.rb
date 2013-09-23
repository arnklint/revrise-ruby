require 'uri'

require "revrise/client"
require "revrise/version"

module RevRise
  def new(options={})
    Client.new(options)
  end
  module_function :new
end

Revrise = RevRise

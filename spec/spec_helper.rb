require "revrise"
require "webmock/rspec"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :should
  end
end

module LastRequest
  def last_request
    @last_request
  end

  def last_request=(request_signature)
    @last_request = request_signature
  end
end

WebMock.extend(LastRequest)
WebMock.after_request do |request_signature, response|
  WebMock.last_request = request_signature
end

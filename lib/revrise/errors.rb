module RevRise
  class ResponseError < HTTParty::ResponseError
    STATUSES = {
      400 => "Bad Request",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error",
      503 => "Service Unavailable",
      504 => "Gateway Timeout"
    }

    def message
      error = response.parsed_response['error'] || response.parsed_response['errors']['error']
      "HTTP status: #{response.code} #{STATUSES[response.code]} Error: #{error}"
    rescue
      "HTTP status: #{response.code} #{STATUSES[response.code]}"
    end
  end
end

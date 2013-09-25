module RevRise
  class ResponseError < HTTParty::ResponseError
    STATUSES = {
      400 => "Bad Request",
      401 => "Unauthorized",
      404 => "Not Found",
      500 => "Internal Server Error"
    }

    def message
      error = response.parsed_response['error'] || response.parsed_response['errors']['error']
      "HTTP status: #{response.code} #{STATUSES[response.code]} Error: #{error}"
    rescue
      "HTTP status: #{response.code} #{STATUSES[response.code]}"
    end
  end
end

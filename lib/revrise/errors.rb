module RevRise
  class ResponseError < HTTParty::ResponseError
    STATUSES = {
      400 => "Bad Request",
      401 => "Unauthorized",
      404 => "Not Found",
      500 => "Internal Server Error"
    }
  end
end

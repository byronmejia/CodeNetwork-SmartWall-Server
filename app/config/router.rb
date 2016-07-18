module Router
  def request(connection, request)
    case request.url
      when '/'
        connection.respond :ok, 'Hello Index'
      when '/hello'
        connection.respond :ok, 'Hello World'
      else
        # type code here
        puts "404 Not Found: #{request.path}"
        connection.respond :not_found, 'No Finds'
    end
  end

  module_function :request
end

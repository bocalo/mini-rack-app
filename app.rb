require_relative 'time_formatter'

class App

  def call(env)
    @request = Rack::Request.new(env)
    handle_request
  end

  private

  def handle_request
    return response(404, 'Page not found') unless @request.path_info == '/time'

    @formatter = TimeFormatter.new(@request.params)
    @formatter.check_format
    if @formatter.success?
      status = 200
      body = @formatter.time
    else
      status = 400
      body = @formatter.error
    end
    response(status, body)
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def response(status, body)
    Rack::Response.new(body, status, headers).finish
  end
end



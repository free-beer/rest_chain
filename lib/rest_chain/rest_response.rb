require "json"

module RestChain
  class RestResponse
    def initialize(status, headers, body)
      @status  = status
      @headers = headers
      @body    = body
    end
    attr_reader :status, :headers, :body

    def success?
      (200..299).include?(@status)
    end

    def json(options={})
      JSON.parse(body, options)
    end
  end
end
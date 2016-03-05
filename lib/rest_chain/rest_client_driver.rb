require "rest_client"

module RestChain
  class RestClientDriver
    def initialize(logger)
      @logger = logger
    end
    attr_reader :logger
    alias :log :logger

    def delete(url, parameters={})
      dispatch(:delete, url, parameters)
    end

    def get(url, parameters={})
      dispatch(:get, url, parameters)
    end

    def patch(url, parameters={})
      dispatch(:patch, url, parameters)
    end

    def post(url, parameters={})
      dispatch(:post, url, parameters)
    end

    def put(url, parameters={})
      dispatch(:put, url, parameters)
    end

    def dispatch(verb, url, parameters={})
      log.debug "Dispatching a #{verb.to_s.upcase} request to #{url} with parameters: #{parameters}"
      response = RestClient::Request.execute(headers: {params: parameters},
                                             method:  verb,
                                             url:     url)
      RestResponse.new(response.code, response.headers, response.body)
    rescue RestClient::Exception => error
      log.debug "#{verb.to_s.upcase} request to #{url} raised a #{error.class.name} exception."
      response = error.response
      RestResponse.new(response.code, response.headers, response.body)
    end
  end
end

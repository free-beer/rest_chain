require "logger"

module RestChain
  class Link
    def initialize(name, predecessor=nil, logger=nil)
      @name        = name
      @predecessor = predecessor
      @logger      = logger ? logger : log
    end

    attr_reader :name, :predecessor

    def delete(parameters={})
      dispatch(:delete, parameters)
    end

    def dispatch(verb, parameters={})
      driver = HTTPDriverClassFactory.manufacture(log).new(log)
      driver.send(verb, url, parameters)
    end

    def get(parameters={})
      dispatch(:get, parameters)
    end

    def log
      if !@logger
        @logger = Logger.new(STDOUT)
        @logger.level = Logger::UNKNOWN
      end
      @logger
    end
    alias :logger :log

    def method_missing(name, *arguments, &block)
      arguments.inject(Link.new(name.to_s, self, log)) do |parent, argument|
        Link.new(argument.to_s, parent, log)
      end
    end

    def patch(parameters={})
      dispatch(:patch, parameters)
    end

    def post(parameters={})
      dispatch(:post, parameters)
    end

    def put(parameters={})
      dispatch(:put, parameters)
    end

    def respond_to?(name, include_private=false)
      true
    end

    def url
      base = (@predecessor ? @predecessor.url : "")
      @predecessor ? "#{base}#{base[-1,1] == '/' ? '' : '/'}#{@name}" : "/#{@name}"
    end
  end
end
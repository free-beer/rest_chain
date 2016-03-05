module RestChain
  class RestChainError < StandardError
    def initialize(message, cause=nil)
      super(message)
      @cause = cause
    end
    attr_reader :cause
  end
end
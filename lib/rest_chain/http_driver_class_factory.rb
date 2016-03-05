module RestChain
  class HTTPDriverClassFactory
    def self.manufacture(log)
      RestClientDriver
    end
  end
end
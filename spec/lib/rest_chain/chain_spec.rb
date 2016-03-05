describe RestChain::Chain do
  let(:host) {
    "localhost"
  }

  let(:path) {
    ["one", "two", "three"]
  }

  let(:port) {
    3645
  }

  let(:logger) {
    Logger.new(STDOUT)
  }

  describe "#initialize()" do
    subject {
      RestChain::Chain
    }

    it "assigns values from the settings passed in" do
      chain = subject.new(host: host, logger: logger, path: "/one/two/three", port: port, scheme: "http")
      expect(chain.host).to eq(host)
      expect(chain.logger).to eq(logger)
      expect(chain.path).to eq(path)
      expect(chain.port).to eq(port)
      expect(chain.scheme).to eq("http")
    end

    it "accepts an array for the path setting" do
      chain = subject.new(host: host, path: path)
      expect(chain.path).to eq(path)
    end

    it "defaults to the HTTPS scheme" do
      chain = subject.new(host: host)
      expect(chain.scheme).to eq(RestChain::Chain::DEFAULT_SCHEME)
    end

    it "creates a default logger if one is not specified" do
      chain = subject.new(host: host)
      expect(chain.logger).not_to be_nil
      expect(chain.log).to eq(chain.logger)
    end

    it "raises an exception is a host is not specified" do
      expect {
        subject.new
      }.to raise_exception(RestChain::RestChainError, "No REST API host specified when creating a chain.")
    end
  end

  describe "#url()" do
    subject {
      RestChain::Chain.new(host: host, logger: logger, path: "/one/two/three", port: port, scheme: "http")
    }

    it "include scheme, host, port and path elements" do
      expect(subject.url).to eq("http://#{host}:#{port}/#{path.join('/')}")
    end
  end
end
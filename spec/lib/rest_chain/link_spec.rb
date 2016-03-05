describe RestChain::Link do
  #-----------------------------------------------------------------------------
  # initialize()
  #-----------------------------------------------------------------------------
  describe "#initialize()" do
    let(:subject) {
      RestChain::Link
    }

    it "accepts just a single name parameter" do
      expect {
        subject.new("test_link")
      }.not_to raise_exception
    end

    it "accepts a name and precessor parameters" do
      link = subject.new("root")
      expect {
        subject.new("first", link)
      }.not_to raise_exception
    end

    it "accepts a name, precessor and logger parameters" do
      link = subject.new("root")
      expect {
        subject.new("first", link, Logger.new(STDOUT))
      }.not_to raise_exception
    end
  end

  #-----------------------------------------------------------------------------
  # name()
  #-----------------------------------------------------------------------------
  describe "#name()" do
    let(:subject) {
      RestChain::Link.new("test_link")
    }

    it "returns the name assigned to the link" do
      expect(subject.name).to eq("test_link")
    end
  end

  #-----------------------------------------------------------------------------
  # predecessor()
  #-----------------------------------------------------------------------------
  describe "#predecessor()" do
    let(:predecessor) {
      RestChain::Link.new("Level1")
    }

    let(:subject) {
      RestChain::Link.new("Level2", predecessor)
    }

    it "returns the name assigned to the link" do
      expect(subject.predecessor).to eq(predecessor)
    end
  end

  #-----------------------------------------------------------------------------
  # log()
  #-----------------------------------------------------------------------------
  describe "#log()" do
    let(:logger) {
      Logger.new(STDOUT)
    }

    let(:subject) {
      RestChain::Link.new("test_link", nil, logger)
    }

    it "returns the name assigned to the link" do
      expect(subject.log).to eq(logger)
    end
  end

  #-----------------------------------------------------------------------------
  # delete()
  #-----------------------------------------------------------------------------
  describe "#delete()" do
    let(:parameters) {
      {one: 1, two: "Two"}
    }

    let(:subject) {
      RestChain::Link.new("test_link")
    }

    it "invokes the #dispatch() method" do
      expect(subject).to receive(:dispatch).with(:delete, {}).once
      subject.delete
    end

    it "passes through any parameters specified to it" do
      expect(subject).to receive(:dispatch).with(:delete, parameters).once
      subject.delete(parameters)
    end
  end

  #-----------------------------------------------------------------------------
  # get()
  #-----------------------------------------------------------------------------
  describe "#get()" do
    let(:parameters) {
      {one: 1, two: "Two"}
    }

    let(:subject) {
      RestChain::Link.new("test_link")
    }

    it "invokes the #dispatch() method" do
      expect(subject).to receive(:dispatch).with(:get, {}).once
      subject.get
    end

    it "passes through any parameters specified to it" do
      expect(subject).to receive(:dispatch).with(:get, parameters).once
      subject.get(parameters)
    end
  end

  #-----------------------------------------------------------------------------
  # patch()
  #-----------------------------------------------------------------------------
  describe "#patch()" do
    let(:parameters) {
      {one: 1, two: "Two"}
    }

    let(:subject) {
      RestChain::Link.new("test_link")
    }

    it "invokes the #dispatch() method" do
      expect(subject).to receive(:dispatch).with(:patch, {}).once
      subject.patch
    end

    it "passes through any parameters specified to it" do
      expect(subject).to receive(:dispatch).with(:patch, parameters).once
      subject.patch(parameters)
    end
  end

  #-----------------------------------------------------------------------------
  # post()
  #-----------------------------------------------------------------------------
  describe "#post()" do
    let(:parameters) {
      {one: 1, two: "Two"}
    }

    let(:subject) {
      RestChain::Link.new("test_link")
    }

    it "invokes the #dispatch() method" do
      expect(subject).to receive(:dispatch).with(:post, {}).once
      subject.post
    end

    it "passes through any parameters specified to it" do
      expect(subject).to receive(:dispatch).with(:post, parameters).once
      subject.post(parameters)
    end
  end

  #-----------------------------------------------------------------------------
  # put()
  #-----------------------------------------------------------------------------
  describe "#put()" do
    let(:parameters) {
      {one: 1, two: "Two"}
    }

    let(:subject) {
      RestChain::Link.new("test_link")
    }

    it "invokes the #dispatch() method" do
      expect(subject).to receive(:dispatch).with(:put, {}).once
      subject.put
    end

    it "passes through any parameters specified to it" do
      expect(subject).to receive(:dispatch).with(:put, parameters).once
      subject.put(parameters)
    end
  end

  #-----------------------------------------------------------------------------
  # url()
  #-----------------------------------------------------------------------------
  describe "#url()" do
    let(:predecessor) {
      RestChain::Link.new("level1")
    }

    let(:subject) {
      RestChain::Link.new("level2", predecessor)
    }

    it "returns a String based on the link structure" do
      expect(subject.url).to eq("/level1/level2")
    end
  end

  #-----------------------------------------------------------------------------
  # dispatch()
  #-----------------------------------------------------------------------------
  describe "#dispatch()" do
    let!(:driver) {
      object = OpenStruct.new(get: nil)
      object.define_singleton_method(:get) {|verb, parameters|}
      object
    }

    let(:parameters) {
      {one: 1, two: "Two"}
    }

    subject {
      RestChain::Link.new("level2", RestChain::Link.new("level1"))
    }

    before do
      allow(RestChain::HTTPDriverClassFactory).to receive(:manufacture).and_return(OpenStruct)
      allow(OpenStruct).to receive(:new).and_return(driver)
    end

    it "invokes the appropriate driver method and specifies an URL and parameters" do
      expect(driver).to receive(:get).with(subject.url, parameters).once
      subject.dispatch(:get, parameters)
    end
  end
end

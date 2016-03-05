require "rest_chain/rest_client_driver"
require "stringio"

describe RestChain::RestClientDriver do
	let(:logger) {
		Logger.new(StringIO.new)
	}

	let(:output) {
		RestChain::RestResponse.new(200, [], "")
	}

	let(:parameters) {
		{one: 1, two: "Two"}
	}

	let(:url) {
		"http://www.unittest.com/api/v1/users"
	}

  subject {
  	 RestChain::RestClientDriver.new(logger)
  }

  #-----------------------------------------------------------------------------
  # logger()
  #-----------------------------------------------------------------------------
  describe "#logger()" do
  	it "retrieves the driver logger instance" do
  		expect(subject.logger).to eq(logger)
  	end
  end

  #-----------------------------------------------------------------------------
  # delete()
  #-----------------------------------------------------------------------------
  describe "#delete()" do
  	it "makes a delete dispatch request" do
  		expect(subject).to receive(:dispatch).with(:delete, url, {}).and_return(output).once
  		subject.delete(url)
  	end

  	it "passes parameters it receives to the dispatch call" do
  		expect(subject).to receive(:dispatch).with(:delete, url, parameters).and_return(output).once
  		subject.delete(url, parameters)
  	end
  end

  #-----------------------------------------------------------------------------
  # get()
  #-----------------------------------------------------------------------------
  describe "#get()" do
  	it "makes a get dispatch request" do
  		expect(subject).to receive(:dispatch).with(:get, url, {}).and_return(output).once
  		subject.get(url)
  	end

  	it "passes parameters it receives to the dispatch call" do
  		expect(subject).to receive(:dispatch).with(:get, url, parameters).and_return(output).once
  		subject.get(url, parameters)
  	end
  end

  #-----------------------------------------------------------------------------
  # patch()
  #-----------------------------------------------------------------------------
  describe "#patch()" do
  	it "makes a patch dispatch request" do
  		expect(subject).to receive(:dispatch).with(:patch, url, {}).and_return(output).once
  		subject.patch(url)
  	end

  	it "passes parameters it receives to the dispatch call" do
  		expect(subject).to receive(:dispatch).with(:patch, url, parameters).and_return(output).once
  		subject.patch(url, parameters)
  	end
  end

  #-----------------------------------------------------------------------------
  # post()
  #-----------------------------------------------------------------------------
  describe "#post()" do
  	it "makes a post dispatch request" do
  		expect(subject).to receive(:dispatch).with(:post, url, {}).and_return(output).once
  		subject.post(url)
  	end

  	it "passes parameters it receives to the dispatch call" do
  		expect(subject).to receive(:dispatch).with(:post, url, parameters).and_return(output).once
  		subject.post(url, parameters)
  	end
  end

  #-----------------------------------------------------------------------------
  # put()
  #-----------------------------------------------------------------------------
  describe "#put()" do
  	it "makes a put dispatch request" do
  		expect(subject).to receive(:dispatch).with(:put, url, {}).and_return(output).once
  		subject.put(url)
  	end

  	it "passes parameters it receives to the dispatch call" do
  		expect(subject).to receive(:dispatch).with(:put, url, parameters).and_return(output).once
  		subject.put(url, parameters)
  	end
  end

  #-----------------------------------------------------------------------------
  # dispatch()
  #-----------------------------------------------------------------------------
  describe "#dispatch()" do
  	let(:success_response) {
  		OpenStruct.new(body: "", code: 200, headers: [])
  	}

  	let(:exception) {
  		exception = RestClient::Exception.new("Something went wrong!")
  		exception.define_singleton_method(:response) do
  			OpenStruct.new(body: "", code: 500, headers: [])
  		end
  		exception
  	}

  	it "calls execute() using the parameters it is passed" do
  		expect(RestClient::Request).to receive(:execute).with({headers: {params: parameters}, method: :delete, url: url}).and_return(success_response).once
  		subject.dispatch(:delete, url, parameters)
  	end

  	it "doesn't raise an exception even if the request does" do
  		expect(RestClient::Request).to receive(:execute).and_raise(exception)
  		expect {
  			subject.dispatch(:put, url)
  		}.not_to raise_exception
  	end
  end
end
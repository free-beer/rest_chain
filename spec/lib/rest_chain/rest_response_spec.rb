describe RestChain::RestResponse do
  describe "#success?()" do
  	it "returns true for responses with a status code between 200 and 299" do
  		expect(RestChain::RestResponse.new(250, [], "").success?).to eq(true)
  	end

  	it "returns false for response with a non-200 status" do
  		expect(RestChain::RestResponse.new(500, [], "").success?).to eq(false)
  	end
  end

  describe "#json()" do
  	let(:body) {
  		{"one" => 1, "two" => "TWO"}
  	}
  	subject {
  		RestChain::RestResponse.new(200, [], body.to_json)
  	}

  	it "converts the response body from JSON to a Ruby object" do
  		expect(subject.json).to eq(body)
  	end

    it "passes any specified options through to the JSON parse" do
      output = subject.json(symbolize_names: true)
      expect(output).to include(:one)
      expect(output).to include(:two)
    end
  end
end

require './google_api_wrapper'

include GoogleAPI
describe "Google API Wrapper" do
  let(:map_data) { MapData.new(origin: "San Francisco, CA", destination: "Sacramento, CA") }

  context "#new" do
    it "should accept required parameters: origin/destination/sensor" do
      lambda { MapData.new(opts = {}) }.should raise_error ArgumentError
    end

    #it "should default sensor parameter to false" do
      #map_data.sensor.should eq false
    #end
  end

  context "JSON method" do
    it "should respond with a JSON object" do
      map_data.response.should be_instance_of Hash
    end

  end

  context "some method" do
    it "should allow for optional parameters"
  end

  context "retrieve metrics"
end

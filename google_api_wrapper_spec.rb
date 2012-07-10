require './google_api_wrapper'
require 'rspec'

include GoogleAPI
describe "MapData" do
  # before(:each) do
  #   @map_data = mock(MapData)
  #   @map_data.stub!(:response).and_return(eval(File.read('map_data_mock.txt')))
  # end

  let(:map_data) { MapData.new(origin: "San Francisco, CA", destination: "Sacramento, CA") }

  context "#new" do
    it "should accept required parameters: origin/destination/sensor" do
      lambda { MapData.new(opts = {}) }.should raise_error ArgumentError
    end
  end

  context "JSON method" do
    it "should respond with a JSON object" do
      map_data.response.should be_instance_of Hash
    end

  end

  context "some method" do
    it "should allow for optional parameters" do
      new_map_data = MapData.new(origin: "San Francisco, CA", destination: "Sacramento, CA", mode: "walking")
      new_map_data.response.to_s.should =~ /:travel_mode=>"WALKING"/
    end
  end

  context "#distance" do
    it "contain return value of distance" do
      map_data.distance.should eq 87.9
    end
  end

  context "#time" do
    it "should return a value of travel time" do
      map_data.time.should eq 5954
    end
  end
end

describe "API Wrapper Module" do
  before(:each) do
    @transit = MapData.new(origin: "San Francisco, CA", destination: "Sacramento, CA", mode: "transit")
    @driving = MapData.new(origin: "San Francisco, CA", destination: "Sacramento, CA")
  end

  it "compares duration" do
    shorter_duration(@transit, @driving).should eq :driving
  end

  it "compares distance" do
    shorter_distance(@transit, @driving).should eq :driving
  end
end

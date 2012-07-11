require './google_api_wrapper'
require 'rspec'

include GoogleAPI
describe "TripData" do
  # before(:each) do
  #   @map_data = mock(TripData)
  #   @map_data.stub!(:response).and_return(eval(File.read('map_data_mock.txt')))
  # end

  let(:trip_data) { TripData.new(origin: "15 Michael Lane, Millbrae, CA",
                                 destination: "717 California Street, San Francisco CA") }

  context "#new" do
    it "should accept required parameters: origin/destination/sensor" do
      lambda { TripData.new(opts = {}) }.should raise_error ArgumentError
    end
  end

  context "JSON method" do
    it "should respond with a JSON object" do
      trip_data.response.should be_instance_of Hash
    end

  end

  context "some method" do
    it "should allow for optional parameters" do
      new_trip_data = TripData.new(origin: "15 Michael Lane, Millbrae, CA",
                                   destination: "717 California Street, San Francisco CA",
                                   mode: "walking")

      new_trip_data.response.to_s.should =~ /:travel_mode=>"WALKING"/
    end
  end

  context "#distance" do
    it "contain return value of distance" do
      trip_data.distance.should eq 19.3
    end
  end

  context "#time" do
    it "should return a value of travel time" do
      trip_data.time.should eq 1732
    end
  end
end

describe "API Wrapper Module" do
  before(:each) do
    @transit = TripData.new(origin: "15 Michael Lane, Millbrae, CA",
                            destination: "717 California Street, San Francisco CA",
                            mode: "transit")

    @driving = TripData.new(origin: "15 Michael Lane, Millbrae, CA",
                            destination: "717 California Street, San Francisco CA")
  end

  it "compares duration" do
    shorter_duration(@transit, @driving).should eq :driving
  end

  it "compares distance" do
    shorter_distance(@transit, @driving).should eq :transit
  end
end

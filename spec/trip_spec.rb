require_relative 'spec_helper'
require_relative '../lib/trip.rb'

describe "Trip" do
  let(:trip) { Trip.new(origin: "15 Michael Lane, Millbrae, CA",
                        destination: "717 California Street, San Francisco CA") }

  context "#new" do
    it "should accept required parameters: origin/destination/sensor" do
      lambda { Trip.new(opts = {}) }.should raise_error ArgumentError
    end
  end

  context "JSON method" do
    it "should respond with a JSON object" do
      trip.response.should be_instance_of Hash
    end
  end

  context "some method" do
    it "should allow for optional parameters" do
      new_trip = Trip.new(origin: "15 Michael Lane, Millbrae, CA",
                          destination: "717 California Street, San Francisco CA",
                          mode: "walking")

      new_trip.parsed_json.to_s.should =~ /:travel_mode=>"WALKING"/
    end
  end

  context "#distance" do
    it "contain return value of distance" do
      trip.distance.should eq 19.3
    end
  end

  context "#time" do
    it "should return a value of travel time" do
      trip.time.should eq 1723
    end
  end
end

describe "comparison class methods" do
  before(:each) do
    @transit = Trip.new(origin: "15 Michael Lane, Millbrae, CA",
                        destination: "717 California Street, San Francisco CA",
                        mode: "transit")

    @driving = Trip.new(origin: "15 Michael Lane, Millbrae, CA",
                            destination: "717 California Street, San Francisco CA")
  end

  it "compares duration" do
    Trip.shorter_duration(@transit, @driving).should eq :driving
  end

  it "compares distance" do
    Trip.shorter_distance(@transit, @driving).should eq :transit
  end
end

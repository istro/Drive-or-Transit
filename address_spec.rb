require 'rspec'
require 'simplecov'
SimpleCov.start
require'./address.rb'
include Transport


describe Address do
  # before(:each) do
  #   user_mock = double "User"
  #   user_mock.stub!(:id).should return(2)
  # end
  
  context "#new" do
    it "instantiates object with address" do
      @address = Address.new(street: "717 California St", city: "Sanfrancisco", state: "CA", zip: 94108, created_at: Time.now, address_type: "Bart", user_id: 1)
      @address.state.should eq "CA"
      @address.zip.should eq 94108
    end
  end

end
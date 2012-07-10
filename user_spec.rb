require 'rspec'
require 'simplecov'
SimpleCov.start
require'./user.rb'
include Transport

describe User do

  context "#new"do
    it "should instantiate a user object with user name" do
      @user = User.new(:first_name => "Sherief", :last_name => "Gharraph")
      @user.first_name.should eq "Sherief"
      @user.last_name.should eq "Gharraph"
    end
  end

  context "#add_address" do
    it "should be able to add user to the database" do

    end
  end
end

describe Address do
  context "#new" do
    it "should instantiate object with adress" do
      @address = Address.new(street: "717 California St", city: "Sanfrancisco", state: "CA", zip: 94108, created_at: Time.now)
      @address.state.should eq "CA"
      @address.zip.should eq 94108
    end
  end
end

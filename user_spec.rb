require 'rspec'
require 'simplecov'
SimpleCov.start
require'./user.rb'
include Transport

describe User do
  before (:each) do
    @sherief = User.new("Sherief", "Gharraph")
  end
  context "#new"do
    it "should be instantiated with first and last name" do
      @sherief.name.should == "Sherief Gharraph"
      # triangulating to make sure we're testing the behavior, not just a single expectation:
      ivan = User.new("Ivan", "Stroganov")
      ivan.name.should == "Ivan Stroganov"
    end
  end
  context "having addresses"
    it 'should count the number of addresses' do
      @sherief.count_addresses.should == 0
    end

    it "should be able to add addresses" do
      expect {
        @sherief.add_address("24 Gidah St, Cairo, Egypt")
      }.should change(@sherief, :count_addresses).by(1)
    end

    it 'should be able to list addresses' do
      @sherief.add_address("24 Gidah St, Cairo, Egypt")
      @sherief.add_address('Hariduse 3, N6o, Tartumaa 61414, Estonia')
      @sherief.list_addresses.index('Cairo').nil?.should be false

    end
end

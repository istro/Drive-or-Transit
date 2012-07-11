require_relative 'spec_helper'
require_relative '../lib/brain.rb'
include Transport

describe Brain do
  before (:each) do
    ivan = User.new(:first_name => 'ivan', :last_name => 'smartass')
    @my_brain = Brain.new(ivan)
  end

  after (:each) do
    User.all.each do |user|
      user.destroy
    end

    Address.all.each do |address|
      address.destroy
    end
  end

  context '#new' do
    it 'instantiates with user object' do
      @my_brain.user.first_name.should eq 'ivan'
    end
  end

  context '#address manipulation' do
    it "adds new address to the current user" do
      puts @my_brain.user.inspect
      expect {
        @my_brain.add_address(:street => "717 california st", :city => "san fran", :state => "CA", :zip => "94108")
        }.to change(@my_brain.user.addresses, :length).by(1)

    end

    it "can list an address with it's sequence number" do
      @my_brain.add_address(:street => "717 california st", :city => "san fran", :state => "CA", :zip => "94108")
      @my_brain.list_addresses[0].should eq "1"
    end

    # it 'can delete addresses'

    it 'can list addresses by creation date' do
       @my_brain.add_address(:street => "717 california st", :city => "san fran", :state => "CA", :zip => "94108", :created_at => "2000-01-01 20:15:50")
       @my_brain.add_address(:street => "2006A Webster St", :city => "san francisco", :state => "CA", :zip => "94123")
       @my_brain.list_addresses.index('Webster').should be_less_then 10
     end


  end
end
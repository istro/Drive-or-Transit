require_relative 'spec_helper'
require_relative '../lib/brain.rb'
include Transport

describe Brain do
  before (:each) do
    ivan = User.new(:first_name => 'ivan', :last_name => 'smartass')
    @my_brain = Brain.new(ivan)
  end

  after (:each) do
    Address.destroy_all
  end

  context '#new' do
    it 'instantiates with user object' do
      @my_brain.user.first_name.should eq 'ivan'
    end
  end

  context '#list addresses' do
      it 'returns an array' do
        @my_brain.list_addresses.should be_an_instance_of Array
      end

      it 'returns an array of strings representing addresses' do
        @my_brain.user.addresses.create(:street => "717 california st",
                                        :city => "san fran",
                                        :state => "CA",
                                        :zip => "94108",
                                        :created_at => "2000-01-01 20:15:50")
        @my_brain.user.addresses.create(:street => "2006A Webster St",
                                        :city => "san francisco",
                                        :state => "CA",
                                        :zip => "94123")
        puts 'addresses:'
        puts @my_brain.user.addresses[0].db_to_str
        puts @my_brain.user.addresses[1].db_to_str
        @my_brain.list_addresses[0].index("Webster").nil?.should be false
        @my_brain.list_addresses[1].index("california").nil?.should be false
      end

    end

  context '#decision' do
    it 'takes two arguments' do
      lambda {@my_brain.decision()}.should raise_error
      lambda {@my_brain.decision("717 california st, san francisco, CA, 94108", "2006A Webster St, san francisco, CA, 94123")}.should_not raise_error
    end

    it 'returns a symbol' do
      @my_brain.decision("717 california st, san francisco, CA, 94108", "2006A Webster St, san francisco, CA, 94123").should == :driving
    end

  end

end
require_relative 'spec_helper'
require_relative '../lib/brain.rb'
include Transport

describe Brain do
  before (:each) do
    ivan = User.new(:first_name => 'ivan', :last_name => 'smartass')
    @my_brain = Brain.new(ivan)
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

      it 'returns an array of strings represting addresses' do
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
        puts @my_brain.user.addresses
        @my_brain.list_address[0].index("Webster").nil?.should be false
        @my_brain.list_address[1].index("california").nil?.should be false
      end

    end



  end

end
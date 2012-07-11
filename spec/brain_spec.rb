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




  end

end
require_relative 'spec_helper'
require_relative '../lib/user.rb'
include Transport

describe User do

  context "#new"do
    it "instantiates a user object with user name" do
      @user = User.new(:first_name => "Sherief", :last_name => "Gharraph")
      @user.first_name.should eq "Sherief"
      @user.last_name.should eq "Gharraph"
    end

    it 'raises error if new user is created without name' do
      lambda {User.new().save}.should raise_exception
    end

    it "assign an id attribute when saved to db" do
      @user2 = User.new(:first_name => 'ivan', :last_name => 'smartass')
      @user2.save
      @user2.id.should be_an_instance_of Fixnum
    end
  end

end



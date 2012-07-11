require_relative 'address'
require_relative 'user'

module Transport
  class Brain
    attr_reader :user
    def initialize(user)
      @user = User.find(:first, :conditions => {:first_name => user.first_name, :last_name => user.last_name}) || User.create(:first_name => user.first_name, :last_name => user.last_name)
    end


  end
end
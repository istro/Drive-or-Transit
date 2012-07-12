require_relative 'address'
require_relative 'user'
require_relative 'trip'

module Transport
  class Brain
    attr_reader :user
    def initialize(user)
      @user = User.find(:first, :conditions => {:first_name => user.first_name, :last_name => user.last_name}) || User.create(:first_name => user.first_name, :last_name => user.last_name)
    end

    def list_addresses
      sorted_addresses = @user.addresses.sort_by(&:created_at).reverse
      output = []
      sorted_addresses.each do |address|
        output.push address.db_to_str
      end
      output
    end

    def decision(origin, destination)
      driving = Trip.new(:origin => origin, :destination => destination)
      transit = Trip.new(:origin => origin, :destination => destination, :mode => "transit")
      Trip.shorter_duration(driving, transit)
    end

  end
end
require_relative 'address'
require_relative 'user'
require_relative 'trip'

module Transport
  class Brain
    attr_reader :user, :advice, :time_difference
    def initialize(user)
      @difference
      @user = user
    end

    def list_addresses
      sorted_addresses = @user.addresses.sort_by(&:created_at)
      output = []
      sorted_addresses.each do |address|
        output.push address.db_to_str
      end
      output
    end

    def decision(origin, destination)
      driving = Trip.new(:origin => origin, :destination => destination)
      transit = Trip.new(:origin => origin, :destination => destination, :mode => "transit")
      @time_difference = Trip.duration_difference(driving, transit)
      Trip.shorter_duration(driving, transit)
    end

  end
end
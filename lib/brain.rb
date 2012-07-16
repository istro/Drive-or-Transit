require_relative 'address'
require_relative 'user'
require_relative 'trip'

module Transport
  class Brain
    attr_reader :user, :advice, :time_difference, :driving
    def initialize(user)
      @difference
      @driving
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
      @driving = Trip.new(:origin => origin, :destination => destination)
      transit = Trip.new(:origin => origin, :destination => destination, :mode => "transit")

      @time_difference = Trip.duration_difference(driving, transit)
      Trip.shorter_duration(driving, transit)
    end

    def save_to_db(user)
      from = Transport::Address.str_from_google(@driving.response[:from])
      to = Transport::Address.str_from_google(@driving.response[:to])
      [from, to].each{ |address| user.addresses.find_by_street(address[:street]) || user.addresses.create(address) }
    end
  end
end
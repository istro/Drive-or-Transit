address1 = Address.create(:street => 'blah', :zip => 'blah')
address2 = Address.create(:street => 'blah', :zip => 'blah')


module Brain
  def self.decide(addr1, addr2, method)
    trips = []
    trips << BartTrip.new(...)
    trips << CarTrip.new(...)

    trips.min_by(method)
  end
end

Brain::decide(addr1, addr2, :distance)

module DriveOrBart
  def self.drive_or_bart(address1, address2)

  end
end

class Trip
  def initialize(from_address, to_address)
    @from_address = from_address
    @to_address   = to_address
  end

  def time
    response[:time]
  end

  # def cost
  #   response[:cost]
  # end

  def distance
    response[:distance]
  end

  def from
  end

  private

  def response
    return @response unless @response.nil?

    # get api response based on the result of self.mode
    @response = {:time     => self.response[:routes][0][:legs][0][:duration][:value],
                 :distance => self.response[:routes][0][:legs][0][:distance][:value],
                 # :cost     => ....
                 :from     => self.response[:routes][0][:legs][0][:start_address],
                 :to       => self.response[:routes][0][:legs][0][:end_address]
               }

  end
end

class BartTrip < Trip
  def mode
    :bart
  end
end

class CarTrip < Trip
  def mode
    :car
  end
end



trip
  id
  from_address
  to_address
  trip_type => 'BartTrip', 'CarTrip'

trip = Trip.find(1)

trip.cost

BartTrip < Trip

bart_trip = BartTrip.new(:from => address1, :to => address2)
car_trip = CarTrip.new(:from => address1, :to => address2)

[bart_trip, car_trip].min_by(&:cost)

bart_trip.cost
car_trip.cost
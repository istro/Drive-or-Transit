require 'rest-client'
require 'json'

module GoogleAPI
  def shorter_duration(mode_one, mode_two)
    [mode_one, mode_two].min_by(&:time).mode.to_sym
  end

  def shorter_distance(mode_one, mode_two)
    [mode_one, mode_two].min_by(&:distance).mode.to_sym
  end

  class Trip
    attr_reader :mode

    def initialize(opts = {})
      @origin      = opts.fetch(:origin) { raise ArgumentError, "need origin" }
      @destination = opts.fetch(:destination) { raise ArgumentError, "need destination" }
      @sensor      = opts.fetch(:sensor) { false }
      @mode        = opts.fetch(:mode) { "driving" }
      @opts = opts
    end

    def response
      @response = {:time     => json_response[:routes][0][:legs][0][:duration][:value],
                   :distance => json_response[:routes][0][:legs][0][:distance][:value],
                   :from     => json_response[:routes][0][:legs][0][:start_address],
                   :to       =>json_response[:routes][0][:legs][0][:end_address]
                   # :cost     => ...json_.
                  }
    end

    def distance
      meters = response[:distance]
      miles = (meters * 6.214e-4).round(1)
    end

    def time
      response[:time]
    end

    private
    def json_response
      into_json = RestClient.get "https://maps.googleapis.com/maps/api/directions/json", { :params => @opts }
      JSON.parse(into_json, :symbolize_names => true)
    end
  end
end

Trip.new(addr1, addr2, mode)
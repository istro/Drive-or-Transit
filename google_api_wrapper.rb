require 'rest-client'
require 'json'

module GoogleAPI
  def shorter_duration(mode_one, mode_two)
    # mode_one.time < mode_two.time ? mode_one.mode.to_sym : mode_two.mode.to_sym
    [mode_one, mode_two].min {|a,b| a.time<=>b.time }.mode.to_sym
  end

  def shorter_distance(mode_one, mode_two)
     # mode_one.time < mode_two.time ? mode_one.mode.to_sym : mode_two.mode.to_sym
     [mode_one, mode_two].min {|a,b| a.distance <=> b.distance }.mode.to_sym
   end

  class MapData
    attr_reader :mode

    def initialize(opts = {})
      opts.fetch(:origin) { raise ArgumentError, "need origin" }
      opts.fetch(:destination) { raise ArgumentError, "need destination" }
      opts.fetch(:sensor) { opts[:sensor] = false }
      @mode = opts.fetch(:mode) { "driving" }
      @opts = opts
    end

    def response
      into_json = RestClient.get "http://maps.googleapis.com/maps/api/directions/json", { :params => @opts }
      JSON.parse(into_json, :symbolize_names => true)
    end

    def distance
      meters = self.response[:routes][0][:legs][0][:distance][:value]
      miles = (meters * 6.214e-4).round(1)
    end

    def time
      self.response[:routes][0][:legs][0][:duration][:value]
    end
  end
end

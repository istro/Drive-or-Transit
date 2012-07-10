require 'rest-client'
require 'json'

module GoogleAPI
  class MapData
    def initialize(opts = {})
      opts.fetch(:origin) { raise ArgumentError, "need origin" }
      opts.fetch(:destination) { raise ArgumentError, "need destination" }
      opts.fetch(:sensor) { opts[:sensor] = false }
      @opts = opts
    end

    def response
      into_json = RestClient.get "http://maps.googleapis.com/maps/api/directions/json", { :params => @opts }
      JSON.parse(into_json, :symbolize_names => true)
    end
  end
end

require './database_setup.rb'

module Transport
  class Address < ActiveRecord::Base
    belongs_to :user
    def self.str_from_google(address)
      arr = address.split(',').map(&:strip)
      puts arr
      state = arr[2].split(' ')[0]
      zip = arr[2].split(' ')[1]
      { :street => arr[0], :city => arr[1], :state => state, :zip => zip }
    end
  end
end
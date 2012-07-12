require_relative '../db/database_setup'

module Transport
  class Address < ActiveRecord::Base
    belongs_to :user

    def self.str_from_google(address)
      arr = address.split(',').map(&:strip)
      state = arr[2].split(' ')[0]
      zip = arr[2].split(' ')[1]
      { :street => arr[0], :city => arr[1], :state => state, :zip => zip }
    end

    def db_to_str
      [self.street, self.city, self.state, self.zip].join(', ')
    end
  end
end
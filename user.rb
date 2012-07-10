require 'SQLite3'

module Transport
  class User
    attr_reader :name, :addresses

    def initialize(fname, lname)
      @name = fname + ' ' + lname
      @addresses = []
    end

    def add_address(address)
      @addresses << address
    end

    def count_addresses
      @addresses.length
    end

    def list_addresses
      to_screen = ''
      counter = 1
      @addresses.each do |address|
        to_screen << counter.to_s + ' ' + address + '\n'
        counter += 1
      end
      to_screen
    end

  end
end
require_relative 'address'
require_relative 'user'

module Transport
  class Brain
    attr_reader :user
    def initialize(user)
      @user = User.find_or_create_by_first_name_and_last_name(user.first_name, user.last_name)
    end

    def add_address(address_hash)
      @user.addresses.create(address_hash)
    end

    def list_addresses
      puts @user.addresses.inspect
    end

  end
end
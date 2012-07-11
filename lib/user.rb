require './database_setup.rb'

module Transport
  class User < ActiveRecord::Base
    has_many :addresses
  end
end
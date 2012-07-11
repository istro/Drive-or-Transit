require_relative '../db/database_setup'

module Transport
  class User < ActiveRecord::Base
    has_many :addresses
  end
end
require './database_setup.rb'

module Transport
  class Address < ActiveRecord::Base
    belongs_to :user
  end
end
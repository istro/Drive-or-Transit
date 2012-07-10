require './database_setup.rb'

module Transport
  class User < ActiveRecord::Base
    has_many :addresses

  end

  class Address < ActiveRecord::Base
    belongs_to :user
  end
end
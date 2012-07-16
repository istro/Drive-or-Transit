require 'sinatra'
require 'sinatra/activerecord'
require 'SQLite3'

# Database connection
ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "db/bart_drive.sqlite3"
)

unless File.exists?('db/bart_drive.sqlite3')
  puts 'creating database...'
  ActiveRecord::Schema.define do
    create_table :users do |t|
      t.column :first_name, :string, :null => false
      t.column :last_name, :string, :null => false
    end

    create_table :addresses do |t|
      t.column :street, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :string
      t.column :created_at, :datetime, :default => 'CURRENT_TIMESTAMP'
      t.column :user_id, :integer, :null => false
    end
  end
end

# Models
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

class User < ActiveRecord::Base
  has_many :addresses
end

# Home
get '/' do
  @title = 'Home'

  # @search = User.params[:]
  @users = User.find(:all)
  
  erb :home
end
require 'active_record'
require 'SQLite3'

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
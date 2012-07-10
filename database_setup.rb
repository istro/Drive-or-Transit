require 'active_record'
require 'SQLite3'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "bart_drive.sqlite3"
)

unless ActiveRecord::Schema
  ActiveRecord::Schema.define do
      create_table :users do |t|
        t.column :first_name, :string
        t.column :last_name, :string
      end

      create_table :addresses do |t|
        t.column :street, :string
        t.column :city, :string
        t.column :state, :string
        t.column :zip, :integer
        t.column :created_at, :time
        t.column :type, :string
        t.column :user_id, :integer
      end
  end
end
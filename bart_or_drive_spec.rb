require './module_bart_or_drive.rb'
require './user.rb'
require './address.rb'
# require './google_api_wrapper'
include Transport

describe "BartOrDrive" do
  context "#address_constructor" do
    user = User.new(first_name: "Matt", last_name: "Nguyen")
    user.save
    new_address = address_constructor(user, {street: "717 California ST", city: "San Francisco", state: "CA", zip: "94108"})
    new_address.should be_instance_of Address
  end

  context "#list_recent_addresses" do
  end

end
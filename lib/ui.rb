require './lib/brain'
require './lib/user'
include Transport

class UI
  def inititalize 
    #get the list of current users from db
    #display them, print options to select or create a new one
    #
    
    start(fname, lname)
  end
  
  def start(fname, lname)
    @origin
    @destination
    make_a_brain(fname, lname)
    puts "Hello #{@user.first_name}!\nWelcome to Bart or Drive!\n\n"
    @command = ' '
    run
  end

  def make_a_brain(fname, lname)
    @user = User.find(:first, :conditions => {:first_name => fname, :last_name => lname}) ||
            User.create(:first_name => fname, :last_name => lname)
    @recents = @user.addresses.length
    @brain = Brain.new(@user)
  end

  def run
    if @origin.nil?
       puts "Select origin!"
       print_options
       @origin = select_address
       run if !@origin.nil?
     else
       puts "\nOrigin: #{@origin}"
       puts "Now, select destination!"
       print_options
       @destination = select_address
       if !@destination.nil? && @destination != @origin
         decision
         need_i_say_more
       elsif @destination == @origin
         puts "You're already at your destination!"
         need_i_say_more
       end
     end
  end

  def select_address
    list_addresses
    puts '------------------------------------------------'
    command = gets.chomp
    if command == 'a'
      add_new_address
    elsif command.to_i(10).between?(1, @recents)
      @brain.list_addresses[command.to_i(10)-1]
    elsif command == 'q'
      puts 'Bye!'
      nil
    else
      puts "Sorry - I don't know that command... Here are your options:"
      run
    end
  end

  def add_new_address
    puts "Enter the new address:"
    raw_address = gets.chomp
    trip_from_google = Trip.new(:origin => raw_address, :destination => "717 California St, San Francisco")
    normalized_string = trip_from_google.response[:from]
    new_address = Transport::Address.str_from_google(normalized_string)
    @user.addresses.create(new_address)

    # recreating @brain to refresh the database reference
    fname = @user.first_name
    lname = @user.last_name
    make_a_brain(fname, lname)
    @origin = @brain.list_addresses[@recents-1] if @origin.nil?
    @destination = @brain.list_addresses[@recents-1] if @destination.nil?
    puts "\n"
    run
  end


  def need_i_say_more
    puts "Do you need more advice (yes/no)?"
    response = gets.chomp
    puts "\n"
    if response == "yes" || response == "y"
      @destination = nil
      @origin = nil
      run
    else
      puts 'Bye!'
    end
  end

  def print_options
    puts <<-EOF

    Here are your options:

    [1-#{@recents}] Select an address from the list below
    [a] Add a new address
    [q] Quit
    EOF
  end


  def list_addresses
    list = "\n"
    @brain.list_addresses.each_with_index do |address, index|
      list << "[#{index+1}]  #{address}\n"
    end
    puts list
  end

  def decision
    puts "\nLet me think about it..."
    sleep 0.5
    puts "."
    sleep 0.5
    puts ".."
    sleep 0.5
    puts "..."
    sleep 0.5
    puts "...."
    # puts "Driving will take ..."
    # puts "Transit will take ..."
    # puts "We advise you to consider #{@brain.decision(@origin, @destination).to_s.upcase}!\n\n"
    puts "#{@brain.decision(@origin, @destination).to_s.upcase} will take #{@brain.time_difference} minutes less time!"
  end
end
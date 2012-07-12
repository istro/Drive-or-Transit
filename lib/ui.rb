require './lib/brain'
require './lib/user'
include Transport

class UI
  def initialize(fname, lname)
    @origin
    @destination
    @user = User.find(:first, :conditions => {:first_name => fname, :last_name => lname}) ||
            User.create(:first_name => fname, :last_name => lname)
    @brain = Brain.new(@user)
    puts "Welcome to Bart or Drive!\n"
    @command = " "
    run
  end

  def run
    while @command != 'q'
      menu_options if @destination.nil?
      @command = gets.chomp
      case @command
      when /^b$/
        view_recently_created if @destination.nil?
      when  /^a$/
        if @destination.nil?
          add_new_address
        else
          # should be executed when destination is selected from recent addresses ?
          # decision
          # need_i_say_more
        end
      else
        decision
      end
    end
  end

  def need_i_say_more
    puts "Do you need more advice (yes / no)?"
    response = gets.chomp
    if response == 'yes'
      @command = ' '
      @destination = nil
      @origin = nil
      self.run
    else
      puts 'Bye!'
      @command = 'q'
      self.run
    end
  end

  def prettify_addresses
    @brain.list_addresses.each_with_index do |address, i|
      "[#{i+1}] #{address.to_s}\n"
    end
  end

  def menu_options
    puts <<-EOF
  Origin: #{ @origin.nil? ? '[select origin]' : @origin }
  Destination: #{@origin.nil? ? 'None' : '[select destination]'}

  Select from the following options:
  [a] Add an address
  [b] View recent addresses
  [q] Quit
    EOF
  end

  def view_recently_created
    prettify_addresses
    match = case @command
            when /\d/
              if @origin.nil?
                @origin = @brain.list_addresses[match-1].to_s
                self.run
              else
                @destination = @brain.list_addresses[match-1].to_s
                self.run
              end
            end
  end

  def add_new_address
    puts "Put in the new address!"
    new_address = " "
    new_address = gets.chomp
    if @origin.nil?
      @origin = new_address
      self.run
    else
      @destination = new_address
      decision
      need_i_say_more
    end
  end

  def decision
    puts "Let me think about it..."
    sleep 0.5
    puts "."
    sleep 0.5
    puts ".."
    sleep 0.5
    puts "..."
    sleep 0.5
    puts "...."
    puts "Coming from #{@origin}"
    puts "going to #{@destination}"
    puts "\tWe advise you to consider #{@brain.decision(@origin, @destination).to_s}!\n"
  end
end

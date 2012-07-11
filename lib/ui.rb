require './lib/brain'

class UI
  def initialize
    @brain = Brain.new
    puts "Welcome to Jurassic Park"
    run
  end

  def run
    command = gets.chomp
    while !command =~ /^q$|^quit$/
      menu_options
      case command
      when /^b$/ && @destination.nil?
        view_recently_created
      else
        decision
      end
    end
  end

  def prettify_addresses
    @brain.list_addresses.each_with_index do |address, i|
      "[#{i+1}] #{address.to_s}\n"
    end
  end

  def menu_options
    "origin: #{@origin}"
    "destination: #{@destination}"
    puts <<-EOF
  Select from the following options:
  [a] Add an address
  [b] View recent addresses
  [q] Quit
    EOF
  end
  
  def view_recently_created
    prettify_addresses
    match = case command
            when /\d/
              if @origin.nil?
                @origin = @brain.select_origin(@brain.list_addresses[match-1].to_s)
              else
                @destination = @brain.select_destination(@brain.addresses[match - 1].to_s)
              end
            end
  end

  def decision
    puts "Your decision has been made:"
    puts "Your decision is..."
    sleep 0.1
    puts "."
    sleep 0.1
    puts ".."
    sleep 0.1
    puts "..."
    sleep 0.1
    puts "...."
    puts "#{@brain.decision.to_s}"
  end
end

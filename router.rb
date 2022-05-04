# TODO: implement the router of your app.
class Router

  def initialize(meals_controller, customers_controller, sessions_controller)
    @running = true
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
  end

  def run
    while @running
      puts ""
      puts ""
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.manager?
          print_manager_menu
          print ">"
          input = gets.chomp.to_i
          route_manager_menu(input)
        else
          print_rider_menu
          print ">"
          input = gets.chomp.to_i
          route_rider_menu(input)
        end
      end
      print `clear`
    end
  end

  def print_manager_menu
    puts "-------------"
    puts "---MENU------"
    puts "-------------"
    puts "1. List all the meals"
    puts "2. Add a meal"
    puts "3. List all customers"
    puts "4. Add a customer"
    puts "9. Exit"
  end

  def print_rider_menu
    puts "-------------"
    puts "---MENU------"
    puts "-------------"
    puts "1. List my undelivered orders"
    puts "2. Mark an order as delivered"
    puts "9. Exit"
  end

  def route_rider_menu(input)
    case input
    when 1 then puts "TODO: list undelivered orders"
    when 2 then puts "TODO: mark order as deliverd"
    when 9
      @running = false
      @current_user = nil
    else
      puts "Wrong input..try again."
    end
  end

  def route_manager_menu(input)
    case input
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 9
      @running = false
      @current_user = nil
    else
      puts "Wrong input..try again."
    end
  end
end

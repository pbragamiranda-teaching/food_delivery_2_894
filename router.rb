# TODO: implement the router of your app.
class Router

  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @running = true
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
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
    puts "5. Add a new order"
    puts "6. List all undelivered orders"
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
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
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
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 9
      @running = false
      @current_user = nil
    else
      puts "Wrong input..try again."
    end
  end
end

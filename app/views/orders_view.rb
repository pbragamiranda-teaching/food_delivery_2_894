class OrdersView
  def display(orders)
    orders.each_with_index do |order, index|
      # 1- Pizza - To: Marlon
      puts "#{index + 1} - #{order.meal.name} - To: #{order.customer.name} - At: #{order.customer.address}"
    end
  end

  def ask_for(something)
    puts "what is the #{something}?"
    print ">"
    gets.chomp
  end
end

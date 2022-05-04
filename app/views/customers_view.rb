class CustomersView
  def display(customers)
    customers.each_with_index do |customer, index|
      # 1 - Name - Address
      puts "#{index + 1} - #{customer.name} -> #{customer.address}"
    end
  end

  def ask_for(something)
    puts "What is the #{something}"
    gets.chomp
  end
end

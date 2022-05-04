class EmployeesView
  def display(employees)
    employees.each_with_index do |employee, index|
      # 1 - Name - $Price
      puts "#{index + 1} - #{employee.username}, #{employee.role}"
    end
  end

  def ask_for(something)
    puts "What is the #{something}?"
    gets.chomp
  end
end

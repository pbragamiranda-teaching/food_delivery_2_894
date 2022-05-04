class MealsView
  def display(meals)
    meals.each_with_index do |meal, index|
      # 1 - Name - $Price
      puts "#{index + 1} - #{meal.name}, $#{meal.price}"
    end
  end

  def ask_for(something)
    puts "What is the #{something}?"
    gets.chomp
  end
end

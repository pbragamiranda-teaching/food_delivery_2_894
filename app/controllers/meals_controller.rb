require_relative "../views/meals_view"
require_relative "../models/meal"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # fetch all meals
    meals = @meal_repository.all
    # ask the view to display
    @meals_view.display(meals)
  end

  def add
    # ask user for name
    name = @meals_view.ask_for("name")
    # ask user for price
    price = @meals_view.ask_for("price").to_i
    # intantiate a new meal
    new_meal = Meal.new(name: name, price: price)
    # send it to repo
    @meal_repository.create(new_meal)
  end
end

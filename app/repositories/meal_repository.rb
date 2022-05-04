require 'csv'
require_relative "../models/meal"

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def find(id)
    # @meals.select { |meal| meal.id == id}.first
    @meals.find { |meal| meal.id == id}
  end

  def create(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  def save_csv
    # headers = %w[id name price]
    # CSV.open(@csv_file_path, "wb", headers: headers, write_headers: true) do |csv|
    CSV.open(@csv_file_path, "wb") do |csv|
      csv <<  %w[id name price]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # read the values and convert values when needed
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      # row[:name] = row[:name]
      # instantiate a Meal
      new_meal = Meal.new(row)
      # add meal to repo
      @meals << new_meal
    end
    # increment / set next_id
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end
end

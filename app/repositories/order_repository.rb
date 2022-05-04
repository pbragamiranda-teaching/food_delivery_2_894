require_relative "../models/order"

class OrderRepository
  def initialize(orders_csv_path, meal_repository, customer_repository, employee_repository)
    @orders = []
    @orders_csv_path = orders_csv_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @next_id = 1
    load_csv if File.exist?(@orders_csv_path)
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_to_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def my_undelivered_orders(employee)
    @orders.select { |order| order.delivered? == false && order.employee == employee }
  end

  def mark_as_delivered(order)
    order.deliver!
    save_to_csv
  end

  def load_csv
    CSV.foreach(@orders_csv_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      row[:delivered] = row[:delivered] == "true"
      new_order = Order.new(row)
      @orders << new_order
    end

    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def save_to_csv
    CSV.open(@orders_csv_path, "wb") do |csv|
      csv <<  %w[id delivered meal_id customer_id employee_id]
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end

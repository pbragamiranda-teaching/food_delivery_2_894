require_relative "../views/orders_view"
require_relative "../views/meals_view"
require_relative "../views/employees_view"
require_relative "../views/customers_view"

class OrdersController

  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @employees_view = EmployeesView.new
    @customers_view = CustomersView.new
  end

  def add
    # List the meals, ask for index, and fetch right meal
    meal = select_meal
    # List the employees, ask for index, and fetch right employee
    employee = select_employee
    # List the customers, ask for index, and fetch right customer
    customer = select_customer
    # Create a new order
    new_order = Order.new(meal: meal, employee: employee, customer: customer)
    # Send it to repo
    @order_repository.create(new_order)
  end

  def select_meal
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @meals_view.ask_for("index").to_i
    return meals[index - 1]
  end

  def select_employee
    employees = @employee_repository.all_riders
    @employees_view.display(employees)
    index = @employees_view.ask_for("index").to_i
    return employees[index - 1]
  end

  def select_customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @customers_view.ask_for("index").to_i
    return customers[index - 1]
  end


  def list_undelivered_orders
    # 1. Get all undelivered orders from orders repo
    undelivered_orders = @order_repository.undelivered_orders
    # 2. Ask view to display them all
    @orders_view.display(undelivered_orders)
  end

  def list_my_orders(employee)
    # 1. Fetch all my undelivered orders
    my_undelivered_orders = @order_repository.my_undelivered_orders(employee)
    # 2. Display them
    @orders_view.display(my_undelivered_orders)
  end

  def mark_as_delivered(employee)
    # 1. List the orders
    my_undelivered_orders = @order_repository.my_undelivered_orders(employee)
    @orders_view.display(my_undelivered_orders)
    # 2. Ask which one to be marked
    index = @orders_view.ask_for("index").to_i
    # 3. Fetch the right order
    order_to_marked = my_undelivered_orders[index -1]
    # 4. Mark as delivered
    @order_repository.mark_as_delivered(order_to_marked)
  end

end

require_relative "../views/customers_view"
require_relative "../models/customer"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    customers = @customer_repository.all
    # ask the view to display
    @customers_view.display(customers)
  end

  def add
    # ask user for name
    name = @customers_view.ask_for("name")
    # ask user for address
    address = @customers_view.ask_for("address")
    # intantiate a new meal
    new_customer = Customer.new(name: name, address: address)
    # send it to repo
    @customer_repository.create(new_customer)
  end
end

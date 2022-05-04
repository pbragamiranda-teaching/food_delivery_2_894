class Order
  attr_accessor :id
  attr_reader :meal, :customer, :delivered, :employee

  def initialize(attributes = {})
    @id = attributes[:id]
    @meal = attributes[:meal] # an instance of Meal
    @customer = attributes[:customer] # an instance of Customer
    @employee = attributes[:employee] # an instance of Employee
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end

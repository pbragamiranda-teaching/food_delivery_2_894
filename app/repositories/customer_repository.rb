require 'csv'
require_relative "../models/customer"

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def find(id)
    # @meals.select { |meal| meal.id == id}.first
    @customers.find { |customer| customer.id == id}
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  def save_csv
    # headers = %w[id name price]
    # CSV.open(@csv_file_path, "wb", headers: headers, write_headers: true) do |csv|
    CSV.open(@csv_file_path, "wb") do |csv|
      csv <<  %w[id name address]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # read the values and convert values when needed
      row[:id] = row[:id].to_i
      new_customer = Customer.new(row)
      @customers << new_customer
    end
    # increment / set next_id
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end
end

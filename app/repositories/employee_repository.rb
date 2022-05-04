require 'csv'
require_relative "../models/employee"

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      # row[:username] = row[:username]
      # row[:password] = row[:password]
      # row[:role] = row[:role]
      new_employee = Employee.new(row)
      # add meal to repo
      @employees << new_employee
    end
    # increment / set next_id
    @next_id = @employees.empty? ? 1 : @employees.last.id + 1
  end
end

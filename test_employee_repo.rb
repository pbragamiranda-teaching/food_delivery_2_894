require_relative "app/repositories/employee_repository"


filepath = "data/employees.csv"

repo = EmployeeRepository.new(filepath)

p repo

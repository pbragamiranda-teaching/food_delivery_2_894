require_relative "../views/sessions_view"

class SessionsController
  def initialize(employee_repository)
    @sessions_view = SessionsView.new
    @employee_repository = employee_repository
  end

  def login
    # 1. Ask user for username
    username = @sessions_view.ask_user_for("username")
    # 2. Ask user for password
    password = @sessions_view.ask_user_for("password")
    # 3. Try to find employee in repo.
    employee = @employee_repository.find_by_username(username)
    # 4. Compare credentials
    if employee && employee.password == password
      @sessions_view.login_sucessful
      return employee
    else
      @sessions_view.wrong_credentials
      login # recursive call
    end
  end
end

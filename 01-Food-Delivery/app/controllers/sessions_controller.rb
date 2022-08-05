require_relative '../views/employee_view'

class SessionsController
  def initialize(employee_repo)
    @employee_repo = employee_repo
    @employee_view = EmployeeView.new
  end

  def login
    # ask the view for username
    username = @employee_view.ask_for(:username)
    # ask the view for password
    password = @employee_view.ask_for(:password)
    # find the instance via username
    employee = @employee_repo.find_by_username(username)
    # check if the information matches
    if employee && employee.password == password
      @employee_view.welcome(username)
      return employee
    else
      # print `clear`
      @employee_view.try_again
      login
    end
  end
end

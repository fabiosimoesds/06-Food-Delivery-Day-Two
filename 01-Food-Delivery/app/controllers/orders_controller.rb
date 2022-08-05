require_relative '../views/order_view'
require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../views/employee_view'
require_relative '../models/order'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_view = OrderView.new
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @employee_view = EmployeeView.new
  end

  def add
    questions = @order_view.add_order_question
    # get the meal array
    meals = @meal_repository.all
    # list the meal
    @meal_view.display_meal(@meal_repository.all)
    # ask for the meal
    # meal_index = @meal_view.ask_info("Which meal index for the order?").to_i - 1
    # find the instance of meal via the meal repo
    # get the customer array
    customers = @customer_repository.all
    # list the customer
    @customer_view.display_customers(customers)
    # ask for the customer
    # customer_index = @customer_view.ask_for("Which customer index for the order?").to_i - 1
    # find the instance of customer via the customer repo
    # get the employee array
    riders = @employee_repository.all_riders
    # list the employee
    @employee_view.display_employees(riders)
    # ask for the employee
    # rider_index = @employee_view.ask_for("Which rider index for the order?").to_i - 1
    # find the instance of employee via the employee repo
    # create an order
    new_order = Order.new(meal: meals[questions[0]], customer: customers[questions[1]], employee: riders[questions[2]])
    # send it to the repo
    @order_repository.create(new_order)
  end

  def list_undelivered_orders
    undelivered_array = @order_repository.undelivered_orders
    @order_view.display_undelivered(undelivered_array)
  end

  def list_my_orders(employee)
    id = employee.id.to_i
    undelivered_orders = @order_repository.find_orders_by_employee(id)
    @order_view.display_undelivered(undelivered_orders)
  end

  def mark_as_delivered(employee)
    list_my_orders(employee)
    index = @order_view.ask_for("Which order would you like to mark as delivered?").to_i - 1
    id = employee.id.to_i
    undelivered_orders = @order_repository.find_orders_by_employee(id)
    undelivered_orders[index].deliver!
    order = undelivered_orders[index]
    @order_repository.update_order(order)
  end
end

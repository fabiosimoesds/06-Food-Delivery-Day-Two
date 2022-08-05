# require_relative 'repositories/order_repository'
# require_relative 'repositories/meal_repository'
# require_relative 'repositories/employee_repository'
# require_relative 'repositories/customer_repository'
# require_relative 'controllers/orders_controller'
# require_relative 'models/order'

# order = Order.new(meal: "pasta", customer: "toninho", employee: "claudio")


# meals_repo = MealRepository.new('../data/meals.csv')
# customers_repo = CustomerRepository.new('../data/customers.csv')
# employees_repo = EmployeeRepository.new('../data/employees.csv')

# repo = OrderRepository.new('../data/orders.csv', meals_repo, customers_repo, employees_repo)

# order_cont = OrdersController.new(meals_repo, customers_repo, employees_repo, repo)

# order_cont.list_undelivered_orders

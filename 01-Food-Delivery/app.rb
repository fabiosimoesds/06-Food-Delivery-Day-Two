#!/usr/bin/env ruby

require_relative 'app/repositories/customer_repository'
require_relative 'app/repositories/meal_repository'
require_relative 'app/repositories/employee_repository'
require_relative 'app/repositories/order_repository'
require_relative 'app/controllers/meals_controller'
require_relative 'app/controllers/customers_controller'
require_relative 'app/controllers/sessions_controller'
require_relative 'app/controllers/orders_controller'
require_relative 'router'

csv_file_meals = File.join(__dir__, 'data/meals.csv')
csv_file_customers = File.join(__dir__, 'data/customers.csv')
csv_file_employees = File.join(__dir__, 'data/employees.csv')
csv_file_orders = File.join(__dir__, 'data/orders.csv')

repo_meals = MealRepository.new(csv_file_meals)
repo_customers = CustomerRepository.new(csv_file_customers)
repo_employees = EmployeeRepository.new(csv_file_employees)
repo_orders = OrderRepository.new(csv_file_orders, repo_meals, repo_customers, repo_employees)


meals_controller = MealsController.new(repo_meals)
customers_controller = CustomersController.new(repo_customers)
sessions_controller = SessionsController.new(repo_employees)
orders_controller = OrdersController.new(repo_meals, repo_customers, repo_employees, repo_orders)

router = Router.new(meals_controller, customers_controller, sessions_controller, orders_controller)

router.run

require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @orders = []
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    load if File.exist?(csv_file_path)
  end

  def create(new_order)
    # Push the new meal to the Array
    @orders.empty? ? new_order.id = 1 : new_order.id = @orders.last.id.to_i + 1
    @orders << new_order
    # Save the array on the CSV
    save
  end

  def all
    @orders
  end

  def undelivered_orders
    @orders.select { |order| order.delivered == false }
  end

  def find_orders_by_employee(employee_id)
    all_und_orders = undelivered_orders
    all_und_orders.select { |order| employee_id == order.employee.id.to_i }
  end

  def update_order(order)
    save
  end

  # def change(index, name, price)
  #   @meals[index].name = name
  #   @meals[index].price = price
  #   # Do the changes
  #   save
  # end

  private

  def load
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      unless row.empty?
        row[:id] = row[:id].to_i
        row[:delivered] = row[:delivered] == "true"
        row[:meal] = @meal_repository.find(row[:meal_id].to_i)
        row[:customer] = @customer_repository.find(row[:customer_id].to_i)
        row[:employee] = @employee_repository.find(row[:employee_id].to_i)
        # need to look for the object on @meal_repository by meal_id, customer_id, employee_id
        @orders << Order.new(row)
      end
    end
  end

  def save
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << ["id", "delivered", "meal_id", "customer_id", "employee_id"]
      @orders.each do |order|
        # need to save meal_id, customer_id, employee_id
        csv << [order.id, order.delivered, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end

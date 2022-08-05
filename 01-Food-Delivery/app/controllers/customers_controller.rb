require_relative '../models/customer'
require_relative '../views/customer_view'

class CustomersController
  def initialize(customer_repo)
    @customers = customer_repo
    @customers_view = CustomerView.new
  end

  def add
    # ask the view for name
    name = @customers_view.ask_for('Customer Name')
    # ask the view for address
    address = @customers_view.ask_for('Customer Address')
    # create a new customer with the info collected
    new_customer = Customer.new(name: name, address: address)
    # send the new customer to repo
    @customers.create(new_customer)
  end

  def list
    customers_array = @customers.all
    @customers_view.display_customers(customers_array)
  end

  def destroy
    # show the list - VIEW
    list
    # ask the customer for a index - VIEW
    index = @customers_view.ask_for('Which customer would you like to delete?').to_i - 1
    # Delete that customer from the repository - Array
    @customers.delete(index)
  end

  def edit
    # show the list - VIEW
    list
    # ask the customer for a index - VIEW
    index = @customers_view.ask_for('Which customer would you like to edit?').to_i - 1
    name = @customers_view.ask_for('New name:')
    address = @customers_view.ask_for('New address:')
    # Display the updated list
    # Edit that customer from the repository - Array
    @customers.change(index, name, address)
  end
end

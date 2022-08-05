require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    load if File.exist?(csv_file_path)
  end

  def create(new_customer)
    @customers.empty? ? new_customer.id = 1 : new_customer.id = @customers.last.id + 1
    @customers << new_customer
    save
  end

  def all
    @customers
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end

  def delete(index)
    @customers.delete_at(index)
    save
  end

  def change(index, name, address)
    @customers[index].name = name
    @customers[index].address = address
    # Do the changes
    save
  end

  private

  def load
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      unless row.empty?
        row[:id] = row[:id].to_i
        @customers << Customer.new(row)
      end
    end
  end

  def save
    CSV.open(@csv_file_path, "wb", write_headers: true, headers: ["id", "name", "address"]) do |csv|
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end

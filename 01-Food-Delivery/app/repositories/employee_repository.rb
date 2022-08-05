require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load if File.exist?(csv_file_path)
  end

  def all_riders
    @employees.select { |employee| employee.role == "rider" }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  private

  def load
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      unless row.empty?
        row[:id] = row[:id].to_i
        @employees << Employee.new(row)
      end
    end
  end
end

require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    load if File.exist?(csv_file_path)
  end

  def create(new_meal)
    # Push the new meal to the Array
    @meals.empty? ? new_meal.id = 1 : new_meal.id = @meals.last.id.to_i + 1
    @meals << new_meal
    # Save the array on the CSV
    save
  end

  def all
    @meals
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  def delete(index)
    @meals.delete_at(index)
    save
  end

  def change(index, name, price)
    @meals[index].name = name
    @meals[index].price = price
    # Do the changes
    save
  end

  private

  def load
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      unless row.empty?
        row[:id] = row[:id].to_i
        row[:price] = row[:price].to_i
        @meals << Meal.new(row)
      end
    end
  end

  def save
    CSV.open(@csv_file_path, "wb", write_headers: true, headers: ["id", "name", "price"]) do |csv|
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end

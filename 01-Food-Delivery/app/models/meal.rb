class Meal
  attr_accessor :id, :name, :price

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
  end

  def self.prepare_row(row)
    row[:id] = row[:id].to_i
    row[:price] = row[:price].to_i
    row
  end

  def self.prepare_hearder
    ['id', 'name', 'price']
  end

  def self.change_element(meal, attributes)
    meal.name = attributes[:name]
    meal.price = attributes[:price]
  end

  def to_csv
    [@id, @name, @price]
  end
end

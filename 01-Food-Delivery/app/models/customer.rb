class Customer
  attr_accessor :id, :name, :address

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @address = attributes[:address]
  end

  def self.prepare_row(row)
    row[:id] = row[:id].to_i
    row
  end

  def self.prepare_hearder
    ["id", "name", "address"]
  end

  def self.change_element(customer, attributes)
    customer.name = attributes[:name]
    customer.address = attributes[:address]
  end

  def to_csv
    [@id, @name, @address]
  end
end

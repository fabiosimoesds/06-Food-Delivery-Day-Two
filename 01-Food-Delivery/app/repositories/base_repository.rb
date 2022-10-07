class BaseRepository
  def initialize(csv_file_path, klass)
    @klass = klass
    @csv_file_path = csv_file_path
    @elements = []
    load if File.exist?(csv_file_path)
  end

  def create(new_element)
    # Push the new element to the Array
    @elements.empty? ? new_element.id = 1 : new_element.id = @elements.last.id.to_i + 1
    @elements << new_element
    # Save the array on the CSV
    save
  end

  def all
    @elements
  end

  def find(id)
    @elements.find { |element| element.id == id }
  end

  def change(attributes)
    element_to_be_changed = @elements[attributes[:index]]
    element = @klass.change_element(element_to_be_changed, attributes)
    # Do the changes
    save
  end

  def delete(index)
    @elements.delete_at(index)
    save
  end

  private

  def load
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      unless row.empty?
        row = @klass.prepare_row(row)
        element = @klass.new(row)
        @elements << @klass.new(row)
      end
    end
  end

  def save
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << @klass.prepare_hearder

      @elements.each do |element|
        csv << element.to_csv
      end
    end
  end
end

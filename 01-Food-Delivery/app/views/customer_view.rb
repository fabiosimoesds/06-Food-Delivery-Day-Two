class CustomerView
  def ask_for(question)
    puts question
    gets.chomp
  end

  def display_customers(customers_array)
    customers_array.each_with_index do |customer, index|
      puts "#{index + 1}. #{customer.name} - #{customer.address}"
    end
  end
end

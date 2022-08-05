class OrderView
  def display_undelivered(undelivered_array)
    undelivered_array.each_with_index do |order, index|
      puts "#{index + 1} - Meal: #{order.meal.name} - Rider: #{order.employee.username} - Cust: #{order.customer.name}"
    end
  end

  def ask_for(question)
    puts question
    gets.chomp
  end

  def add_order_question
    puts "Which meal index for the order?"
    meal_index = gets.chomp.to_i - 1
    puts "Which customer index for the order?"
    customer_index = gets.chomp.to_i - 1
    puts "Which rider index for the order?"
    rider_index = gets.chomp.to_i - 1
    [meal_index, customer_index, rider_index]
  end
end

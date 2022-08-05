class MealView
  def ask_info(question)
    puts question
    return gets.chomp
  end

  def display_meal(array)
    array.each_with_index do |meal, index|
      puts "#{index + 1}. #{meal.name.capitalize} $#{meal.price}.00"
    end
  end
end

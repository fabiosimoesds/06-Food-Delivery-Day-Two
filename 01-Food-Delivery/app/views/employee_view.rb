class EmployeeView
  def ask_for(keyword)
    puts keyword
    gets.chomp
  end

  def display_employees(employees_array)
    employees_array.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}"
    end
  end

  def try_again
    puts "Wrong Credentials, please try again"
  end

  def welcome(username)
    puts "Welcome to FoodDelivery #{username.capitalize}!"
  end
end

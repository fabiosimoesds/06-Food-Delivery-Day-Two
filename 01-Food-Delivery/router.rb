class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  # def manager_loop
  #   display_tasks_meals
  #   display_tasks_customers
  #   action = gets.chomp.to_i
  #   print `clear`
  #   manager_meals_action(action)
  # end

  # def rider_loop
  #     display_tasks_riders
  #     action = gets.chomp.to_i
  #     print `clear`
  #     riders_action(action)
  # end

  # def run
  #   puts "Welcome to the FoodDelivery!"
  #   puts "           --           "
  #   while @running
  #     # ask for login
  #     login_menu
  #     action = gets.chomp.to_i
  #     if action == 1
  #       @employee = @sessions_controller.login
  #       until action.zero?
  #         if @employee.manager?
  #           display_tasks_meals
  #           display_tasks_customers
  #           action = gets.chomp.to_i
  #           print `clear`
  #           manager_meals_action(action)
  #         else
  #           display_tasks_riders
  #           action = gets.chomp.to_i
  #           print `clear`
  #           riders_action(action)
  #         end
  #       end
  #     else
  #       stop
  #     end
  #   end
  # end

  private

  def manager_meals_action(action)
    case action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @meals_controller.destroy
    when 4 then @meals_controller.edit
    when 0 then run
    else
      customers_action(action)
    end
  end

  def customers_action(action)
    case action
    when 5 then @customers_controller.add
    when 6 then @customers_controller.list
    when 7 then @customers_controller.destroy
    when 8 then @customers_controller.edit
    when 9 then @orders_controller.add
    when 10 then @orders_controller.list_undelivered_orders
    else
      puts "Please press 0, 1, 2, 3, 4, 5, 6, 7, 9 or 10"
    end
  end

  def stop
    @running = false
  end

  def login_menu
    puts "What do you want to do next?"
    puts "1 - Login"
    puts "2 - Exit"
  end

  def display_tasks_meals
    puts ""
    puts "What do you want to do next?"
    puts "1 - Create a new meal"
    puts "2 - List all meals"
    puts "3 - Destroy a meal"
    puts "4 - Edit a meal"
  end

  def display_tasks_customers
    puts "5 - Create a new Customer"
    puts "6 - List all customers"
    puts "7 - Destroy a customer"
    puts "8 - Edit a customer"
    puts "9 - Add new Order"
    puts "10 - List Undelivered Orders"
    puts "0 - Logout"
  end

  def riders_action(action)
    case action
    when 1 then @orders_controller.mark_as_delivered(@employee)
    when 2 then @orders_controller.list_my_orders(@employee)
    when 0 then run
    else
      puts "Please press 0, 1 or 2"
    end
  end

  def display_tasks_riders
    puts ""
    puts "What do you want to do next?"
    puts "1 - Mark one of my orders as delivered"
    puts "2 - List all my undelivered orders"
    puts "0 - Logout"
  end
end

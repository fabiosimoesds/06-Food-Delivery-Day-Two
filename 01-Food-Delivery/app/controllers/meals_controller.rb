require_relative '../models/meal'
require_relative '../views/meal_view'

class MealsController
  def initialize(meal_repository)
    @meals = meal_repository
    @meal_view = MealView.new
  end

  def add
    # Get the information from the user - VIEW
    name = @meal_view.ask_info("What is the name of the meal?")
    price = @meal_view.ask_info("What is the price of the meal?").to_i
    # Use the information to create a new meal
    new_meal = Meal.new(name: name, price: price)
    # save the mew on the respository
    @meals.create(new_meal)
  end

  def list
    meal_array = @meals.all
    # send the list to view
    @meal_view.display_meal(meal_array)
    # get the list back with a nice display
  end

  def destroy
    # show the list - VIEW
    list
    # ask the customer for a index - VIEW
    index = @meal_view.ask_info('Which meal would you like to delete?').to_i - 1
    # Delete that meal from the repository - Array
    @meals.delete(index)
  end

  def edit
    # show the list - VIEW
    list
    # ask the customer for a index - VIEW
    index = @meal_view.ask_info('Which meal would you like to edit?').to_i - 1
    name = @meal_view.ask_info('New name:')
    price = @meal_view.ask_info('New Price:')
    # Display the updated list
    # Edit that meal from the repository - Array
    @meals.change(index, name, price)
  end
end

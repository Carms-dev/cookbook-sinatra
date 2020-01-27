# The view is responsible for all the puts and gets of your code.
# Make sure you never have those words anywhere else! (except maybe for debugging)
class View
  # def initialize
  # end
  def display(recipes)
    puts "no recipes exist in this cookbook" if recipes == []

    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}"
    end
    puts ""
  end

  def ask_for_recipe_info
    recipe = {}
    print "Recipe name?\n> "
    # print "> "
    recipe[:name] = gets.chomp

    print "Recipe description?\n> "
    # print "> "
    recipe[:description] = gets.chomp

    print "Prep time? (mins)\n> "
    # print "> "
    recipe[:prep_time] = gets.chomp + "mins"

    print "Difficulty? (Easy or More Effort)\n> "
    # print "> "
    recipe[:difficulty] = gets.chomp

    puts "Okay, #{recipe[:name]} is added to the cookbook"
    return recipe
  end

  def ask_for_i
    puts "which recipe? (index)"
    print '> '
    # may need to validate the answer
    gets.chomp.to_i - 1
    # may need a way to exit
  end

  def ask_for_ingredient
    puts "What ingredient would you like a recipe for?"
    print "> "
    # may need to validate the answer
    ingredient = gets.chomp
    puts ""
    puts "Looking for \"#{ingredient}\" recipes on the Internet..."
    return ingredient
  end

  def display_status(recipes)
    puts "-- Here are all your recipes --"
    recipes.each_with_index do |recipe, index|
      checkbox = recipe.done ? "[x]" : "[ ]"
      puts "#{index + 1}. #{checkbox} #{recipe.name} \(#{recipe.prep_time}\)"
    end
    puts ""
  end
end

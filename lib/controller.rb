require_relative 'recipe'
require_relative 'view'
require_relative 'scrape_service'

# require 'open-uri'
# require 'nokogiri'

class Controller
  # takes an instance of the Cookbook as an argument.
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  # list all the recipes
  def list
    # ask repo for all
    recipes = @cookbook.all
    # ask view to display
    @view.display(recipes)
  end

  # create a new recipe
  def create
    # ask view for recipe hash
    recipe_hash = @view.ask_for_recipe_info
    # create a new recipe
    recipe = Recipe.new(recipe_hash)
    # add the recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  # destroy an existing recipe
  def destroy
    # list all receipe
    list
    # ask view for recipe index
    index = @view.ask_for_i
    # remove the recipe from the cookbook
    @cookbook.remove_recipe(index)
  end

  def import
    # ask view for the ingredient
    ingredient = @view.ask_for_ingredient
    # search on bbcgoodfood
    # five_recipes = search(ingredient)
    five_recipes = ScrapeService.new(ingredient).call
    # ask view to display the first 5 & ask index to import
    @view.display(five_recipes)
    index = @view.ask_for_i
    # get specific details from scrapper.
    # recipe_chosen = scrap_details(five_recipes[i_chosen])
    # create a new recipe
    # new_recipe = Recipe.new(recipe_chosen)
    # store recipe in cookbook
    @cookbook.add_recipe(five_recipes[index])
  end

  def mark_as_done
    # ask cookbook for all recipes
    recipes = @cookbook.all
    # ask view to display status & get an the index back
    @view.display_status(recipes)
    index = @view.ask_for_i
    # ask cookbook to update that recipe with index
    @cookbook.recipe_done(index)
    # view to display status again
    @view.display_status(recipes)
  end

  def mark_as_undone
    # ask cookbook for all recipes
    recipes = @cookbook.all
    # ask view to display status & get an the index back
    @view.display_status(recipes)
    index = @view.ask_for_i
    # ask cookbook to update that recipe with index
    @cookbook.recipe_undone(index)
    # view to display status again
    @view.display_status(recipes)
  end

  # private

  # def search(ingredient)
  #   url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
  #   html_file = open(url).read
  #   html_doc = Nokogiri::HTML(html_file)

  #   arr = html_doc.search('.teaser-item__title a').map do |element|
  #     { name: element.text.strip,
  #       link: element.attribute('href').value }
  #   end
  #   return arr.first(5)
  # end

  # def scrap_details(recipe)
  #   url = "https://www.bbcgoodfood.com#{recipe[:link]}"
  #   html_file = open(url).read
  #   html_doc = Nokogiri::HTML(html_file)

  #   recipe[:description] = html_doc.search('.field-item p').text.strip
  #   recipe[:prep_time] = html_doc.search('.recipe-details__cooking-time-prep span').text.strip
  #   recipe[:difficulty] = html_doc.search('.recipe-details__item--skill-level span').text.strip

  #   return recipe
  # end
end

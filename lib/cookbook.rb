require 'csv'
require_relative 'recipe'

class Cookbook
  # initialize(csv_file_path) which loads existing Recipe from the CSV
  def initialize(csv_file_path)
    @filepath = csv_file_path
    @recipes = []

    csv_options = { col_sep: ',', quote_char: '"' } # , headers: :first_row
    CSV.foreach(@filepath, csv_options) do |row|
      recipe_hash = { name: row[0], description: row[1],
                      prep_time: row[2], difficulty: row[3], done: row[4].downcase == "true" }
      recipe = Recipe.new(recipe_hash)
      @recipes << recipe
    end
  end

  # returns all the recipes
  def all
    @recipes
  end

  # adds a new recipe to the cookbook
  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  # removes a recipe from the cookbook.
  def remove_recipe(index)
    @recipes.delete_at(index)
    update_csv
  end

  def status_update(index)
    recipe = @recipes[index]
    recipe.done == true ? recipe.undone! : recipe.done!
    update_csv
  end

  # def recipe_done(index)
  #   # p @recipes[index]
  #   @recipes[index].done!
  #   # p @recipes[index]
  #   # p @recipes
  #   update_csv
  # end

  # def recipe_undone(index)
  #   @recipes[index].undone!
  #   update_csv
  # end

  private

  def update_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@filepath, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        # p recipe
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done]
      end
    end
  end
end

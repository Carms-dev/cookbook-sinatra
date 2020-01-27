# require_relative 'cookbook'    # You need to create this file!
# require_relative 'controller'  # You need to create this file!
# require_relative 'router'
require 'open-uri'
require 'nokogiri'

# # csv_file   = File.join(__dir__, 'recipes.csv')
# p cookbook = Cookbook.new # (csv_file)
# p controller = Controller.new(cookbook)

# # router = Router.new(controller)

# # # Start the app
# # router.run


def search(ingredient)
  url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  arr = html_doc.search('.node-recipe').map do |element|
    recipe_args = {
      name: element.search('.teaser-item__title a').text.strip,
      description: element.search('.field-items div').text.strip,
      prep_time: element.search('.teaser-item__info-item--total-time').text.strip,
      difficulty: element.search('.teaser-item__info-item--skill-level').text.strip
    }
    Recipe.New(recipe_args)
  end
  return arr.first(5)
end

search("strawberry")

# def scrap_details # (recipe)
#   url = "https://www.bbcgoodfood.com/recipes/tomato-thyme-cod"
#   html_file = open(url).read
#   html_doc = Nokogiri::HTML(html_file)
#   recipe = {}

#   p recipe[:description] = html_doc.search('.field-item p').text.strip
#   p recipe[:prep_time] = html_doc.search('.recipe-details__cooking-time-prep span').text.strip
#   p recipe[:difficulty] = html_doc.search('.recipe-details__item--skill-level span').text.strip
# end

# scrap_details

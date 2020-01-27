require_relative 'recipe'

require 'open-uri'
require 'nokogiri'

class ScrapeService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # TODO: return a list of `Recipes` built from scraping the web.
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{@keyword}"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    arr = html_doc.search('.node-recipe').map do |element|
      args = { name: element.search('.teaser-item__title a').text.strip,
               description: element.search('.field-items div').text.strip,
               prep_time: element.search('.teaser-item__info-item--total-time').text.strip,
               difficulty: element.search('.teaser-item__info-item--skill-level').text.strip }
      Recipe.new(args)
    end
    return arr.first(5)
  end


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

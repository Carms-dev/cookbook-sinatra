require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative 'lib/cookbook'
require_relative 'lib/scrape_service.rb'

csv_file = File.join(__dir__, 'lib/recipes.csv')
cookbook = Cookbook.new(csv_file)

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @recipes = cookbook.all
  erb :index
end

# create feature
get '/create' do
  erb :create
end

post '/new' do
  recipe = Recipe.new(params)
  cookbook.add_recipe(recipe)
  redirect '/'
end

# destroy feature
get '/destroy' do
  @recipes = cookbook.all
  erb :destroy
end

post '/delete' do
  i = params[:delete_i].to_i - 1
  cookbook.remove_recipe(i)
  redirect '/'
end

# import feature
get '/import' do
  erb :import
end

post '/search' do
  @keyword = params[:ingredient]
  scraper = ScrapeService.new(@keyword)
  @top_recipes = scraper.call
  erb :search_results
end

post '/imported' do
  @keyword = params[:import_key]
  scraper = ScrapeService.new(@keyword)
  @top_recipes = scraper.call
  recipe = @top_recipes[params[:import_i].to_i - 1]
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/update_status' do
  @recipes = cookbook.all

  erb :update_status
end

post '/updated' do
  i = params[:update_i].to_i - 1
  cookbook.status_update(i)
  redirect '/'
end
# get '/about' do
#   erb :about/search_results
# end

# get '/team/:username' do
#   puts params[:username]
#   "The username is #{params[:username]}"
# end

# get '/team/:username' do
#   binding.pry  # <= code will stop here for HTTP request localhost:4567/team/someone
#   # [...]
# end



# params can be filled from 3 places:
#     Routing parameters (like /team/:username)
#     Query string parameters (if the URL is like /search?keyword=lewagon)
#     Body from HTTP POST queries (coming from <form action="post" />)


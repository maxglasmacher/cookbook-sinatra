require_relative 'cookbook'
require_relative "model"
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

get '/' do
  @recipes = cookbook.all
  erb :view_index
end

get '/new' do
  erb :new
end

get '/delete/:index' do
  index_remove = params["index"].to_i
  cookbook.remove_recipe(index_remove)
  redirect "/"
end

post '/create' do
  name = params["name"]
  description = params["description"]
  prep_time = params["prep time"]
  difficulty = params["difficulty"]
  new_recipe = Recipe.new(name, description, prep_time, difficulty)
  cookbook.add_recipe(new_recipe)
  redirect "/"
end


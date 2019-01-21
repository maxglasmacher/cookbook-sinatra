require "csv"
require_relative "model"

class Cookbook
  attr_accessor :csv_file_path, :recipes
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    read_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    write_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    write_csv
  end

  private

  def write_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, "wb", csv_options) do |csv|
      @recipes.each do |recip|
        csv << recip.to_a
      end
    end
  end

  def read_csv
    CSV.foreach(@csv_file_path) do |row|
      recipe_object = Recipe.new(row[0], row[1], row[2], row[3], row[4])
      @recipes << recipe_object
    end
  end
end

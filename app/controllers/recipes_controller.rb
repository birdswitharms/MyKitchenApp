class RecipesController < ApplicationController
  before_action :load_recipe, only: [:show]


  def index
    @recipes = Recipe.all
  end

  def show

  end


private

def load_recipe
  @recipe = Recipe.find(params[:id])
end







end

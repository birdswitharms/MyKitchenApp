class RecipesController < ApplicationController
  before_action :load_recipe, only: [:show]


  def index
    @all_recipes = Recipe.all

    if current_user
      @recipes = current_user.kitchen.recipes.uniq
    end
  end

  def show
    @ingredients = load_recipe.ingredients
    @steps = load_recipe.steps
  end

  def new

  end

  def create
    @recipe = Recipe.new(recipe_params)
      if @recipe.save
        flash[:notice] = "New recipe successfully added"
       redirect_to root_path
      else
        redirect_to root_path
        puts "="*20
        puts "#{@recipe.errors.full_messages}"
        puts "="*20
      end
  end

private

def load_recipe
  @recipe = Recipe.find(params[:id])
end

def recipe_params
  params.require(:recipe).permit(:name, :calories, :steps)
end






end

class RecipesController < ApplicationController
  before_action :load_recipe, only: [:show]


  def index
    @all_recipes = Recipe.all

    if current_user
      @all_recipes = Recipe.valid_recipes_with_pantry(current_user)
    end
  end

  def show
    @ingredients = load_recipe.ingredients
    @steps = load_recipe.steps
  end

  def new
    @foods = Food.all.to_a
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @step = Step.new(step_params)
      if @recipe.save && @step.save
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
  params.require(:recipe).permit(:name, :steps)
end

def step_params
  params.require(:recipe).permit(:recipe_id, :steps)
end






end

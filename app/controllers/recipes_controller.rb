class RecipesController < ApplicationController
  before_action :load_recipe, only: [:show]


  def index
    @all_recipes = Recipe.all

    if current_user
      @all_recipes = Recipe.valid_recipes_with_pantry(current_user)
    end

    @all_recipes = if params[:term]
      Recipe.where('name LIKE ?', "%#{params[:term]}%")
    else
      Recipe.all
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

  def favorite
    favorite = Favorite.new(user: current_user, recipe: Recipe.find(params[:id]))
    if favorite.save
      puts "="*20
      puts "Favorite Successfull"
    else
      puts "="*20
      puts "Facorite Failed"
    end
  end

private

def load_recipe
  @recipe = Recipe.find(params[:id])
end

def recipe_params
  params.require(:recipe).permit(:name, :steps, :term)
end

def step_params
  params.require(:recipe).permit(:recipe_id, :steps)
end






end

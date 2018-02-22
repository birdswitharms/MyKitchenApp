class RecipesController < ApplicationController
  before_action :load_recipe, only: [:show, :add_shoppinglist]


  def index
    @all_recipes = Recipe.all

    if params[:term]
      @all_recipes = Recipe.where('name LIKE ?', "%#{params[:term]}%")
    else
      @all_recipes = Recipe.all
    end

    if current_user
      @all_recipes = Recipe.valid_recipes_with_pantry(current_user)
      if params[:allrecipes]
        @all_recipes = Recipe.all
      end
    end
  end

  def show
    @ingredients = load_recipe.ingredients
    @steps = load_recipe.steps
  end

  def search

  end

  def searchaction
    included = []
    excluded = []

    params[:include].each do |key, value|
      unless value == ""
        included << value.capitalize
      end
    end

    params[:exclude].each do |key, value|
      unless value == ""
        excluded << value.capitalize
      end
    end

    @all_recipes = Recipe.find_ingredient(included, excluded)
    render :index
  end

  def new
    @foods = Food.all.to_a
  end

  def create
    @recipe = Recipe.new(recipe_params)
      if @recipe.save

        params[:recipe][:steps].each do |key, value|
          step = Step.new(content: value, recipe_id: @recipe.id)
          if step.save
            @recipe.steps << step
          else
            puts "="*20
            puts "#{@recipe.errors.full_messages}"
            puts "="*20
          end
        end

        params[:recipe][:ingredient].each do |key, value|

        food = Food.find_by(name: value.capitalize)
        if food
          ingredient = Ingredient.new(food_id: food.id, measurement_unit: "1 testunit" )
        else
          flash[:notice] = "Food not found, Recipe was not created."
          @recipe.destroy
        end

        if ingredient
          @recipe.ingredients << ingredient
        else
          puts "="*20
          puts "#{@recipe.errors.full_messages}"
          puts "="*20
        end
      end

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

  def add_shoppinglist
    @recipe.foods.each do |food|
      shoppinglist = Shoppinglist.new(food: food, user: current_user)
      if shoppinglist.save
        puts "="*20
        puts "ShoppingList Saved Successfull"
      else
        puts "="*20
        puts "ShoppingList Failed to Save"
        puts shoppinglist.errors.full_messages
        puts "="*20
      end
    end
    redirect_to root_path
  end

private

def load_recipe
  @recipe = Recipe.find(params[:id])
end

def recipe_params
  params.require(:recipe).permit(:name, :ingredient, :image_url, :term)
end

def search_params
  params.require(:include, :exclude)
end






end

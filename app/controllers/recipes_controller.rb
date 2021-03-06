require 'uri'

class RecipesController < ApplicationController

  before_action :load_recipe, only: [:show, :review, :add_shoppinglist, :addsome_shoppinglist, :user_made, :add_weeklyplanner]



  def index
    @all_recipes = Recipe.all

    if current_user
      @all_recipes_with_ingredients = Recipe.valid_recipes_with_pantry(current_user)
      @all_recipes_with_appliances = Recipe.valid_recipes_with_appliances(current_user)
      puts "*"*20
      ap @all_recipes_with_appliances
      @all_recipes = @all_recipes_with_ingredients & @all_recipes_with_appliances
      @partial_recipes = Recipe.valid_recipes_partial(current_user)
      if params[:allrecipes]
        @all_recipes = Recipe.all
        @partial_recipes = []
      end
    end

    if params[:term]
      @all_recipes = Recipe.where('lower(name) LIKE ?', "%#{params[:term].downcase}%")
    end

  end

  def show
    @ingredients = load_recipe.ingredients
    @nutrition = @recipe.recipe_nutrition_totals
    @steps = load_recipe.steps
    @reviews = Review.where(recipe: @recipe)
    if current_user
      if current_user.favorites.find_by(recipe: @recipe)
        @favorited = true
      else
        @favorited = false
      end
    end
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
    @foods = Food.all.map(&:name).join("~")
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    begin
      URI.parse(@recipe.image_url)
    rescue
      @recipe.image_url = ""
    else
      unless URI.parse(@recipe.image_url).host && URI.parse(@recipe.image_url).path
        @recipe.image_url = ""
      end
    end

    recipe_steps
    recipe_ingredients

    if @recipe.save
      flash[:notice] = "New recipe successfully added"
      if @recipe.image_url == ""
        @recipe.update(image_url: 'https://irp-cdn.multiscreensite.com/5f8d5410/dms3rep/multi/default-placeholder.png')
      end
      redirect_to root_path
    else
      flash.now[:errors] = @recipe.errors.full_messages
      render :new
    end

  end

  def recipe_steps
    params[:recipe][:steps].each do |key, value|
      unless value.blank?
        @recipe.steps.new(content: value.downcase)
      end
    end
  end

  def recipe_ingredients
    params[:recipe][:ingredient].each { |key, value|
      puts "*"*20
      puts "current ingredint: " + value
      puts "*"*20

      unless value.blank?
        existing_food = Food.find_by(name: value.capitalize)
      else
        next
      end

      if existing_food
        ingredient = Ingredient.new(food: existing_food, measurement_unit: params[:recipe][:measurement]["#{key}"] + " " + params["measurement_select_#{key}"])
        existing_ingredient = Ingredient.find_by(food: ingredient.food, measurement_unit: ingredient.measurement_unit)

        if (existing_ingredient)
          ingredient = existing_ingredient
        end

      else
        ingredient = Ingredient.new(measurement_unit: params[:recipe][:measurement]["#{key}"])
        # flash[:errors] = "#{value} not found, Recipe was not created."
      end
      @recipe.ingredients << ingredient
    }
  end

  def favorite
    @favorite = Favorite.new(user: current_user, recipe: Recipe.find(params[:id]))
    if @favorite.save
      puts "="*20
      puts "Favorite Successfull"
    else
      puts "="*20
      puts "Favorite Failed"
      flash[:errors] = @favorite.errors.full_messages
    end
  end

  def review
    @review = Review.new(user: current_user, recipe: Recipe.find(params[:id]))
    @review.comment = params[:comment]
    if @review.save
      puts "="*20
      puts "Review Successfull"
      respond_to do |format|
        format.html do
            render :show
          end
        format.json do
          if request.xhr?
            render json: {user_name: User.find(@review.user_id).name, comment: @review.comment, time: @review.created_at.strftime('%b-%d-%Y') }
          end
        end
      end
      # redirect_to recipe_path(@recipe)
    else
      puts "="*20
      puts "Review Failed"
      flash[:errors] = @review.errors.full_messages
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
        flash[:errors] = shoppinglist.errors.full_messages
        puts "="*20
      end
    end
    redirect_to users_shoppinglist_path
  end

  def addsome_shoppinglist
    @foods = Recipe.add_some_food_shoppinglist(@recipe, current_user)
    @foods.each do |fooditem|
      shoppinglist = Shoppinglist.new(food: fooditem, user: current_user)
      # ap shoppinglist
      if shoppinglist.save
        puts "="*20
        puts "ShoppingList Saved Successfull"
      else
        puts "="*20
        puts "ShoppingList Failed to Save"
        flash[:errors] = shoppinglist.errors.full_messages
        puts "="*20
      end
    end
    redirect_to users_shoppinglist_path
  end

  def user_made
    unless current_user.histories.any? {|history| history.recipe_id == @recipe.id }
      history = History.new(user: current_user, recipe: @recipe)
      if history.save
        puts "="*20
        puts "History Saved Successfull"
      else
        puts "="*20
        puts "History Failed to Save"
        flash[:errors] = history.errors.full_messages
      end
    end
      redirect_to root_path
  end

  def add_weeklyplanner
    @planner = WeeklyPlanner.new(recipe_id: @recipe.id, user: current_user)
    if @planner.save
      puts "="*20
      puts "Recipe added to Weekly Planner"
      puts "="*20
      redirect_to root_path
    else
      puts "="*20
      puts "Recipe failed to save to Weekly Planner"
      flash[:errors] = @planner.errors.full_messages
      puts "="*20
    end
  end

private

def load_recipe
  @recipe = Recipe.find(params[:id])
end

def recipe_params
  params.require(:recipe).permit(:name, :image_url, :term, :youtube_url, :steps, :measurement)
end

def search_params
  params.require(:include, :exclude)
end

end

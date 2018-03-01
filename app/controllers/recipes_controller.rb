class RecipesController < ApplicationController

  before_action :load_recipe, only: [:show, :review, :add_shoppinglist, :addsome_shoppinglist, :user_made]

  def index
    @all_recipes = Recipe.all

    if current_user
      @all_recipes_with_ingredients = Recipe.valid_recipes_with_pantry(current_user)
      @all_recipes_with_appliances = Recipe.valid_recipes_with_appliances(current_user)
      @all_recipes = @all_recipes_with_ingredients & @all_recipes_with_appliances
      @partial_recipes = Recipe.valid_recipes_partial(current_user)
      if params[:allrecipes]
        @all_recipes = Recipe.all
      end
    end

    if params[:term]
      @all_recipes = Recipe.where('name LIKE ?', "%#{params[:term]}%")
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
    @foods = Food.all.to_a
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.update(user: current_user)
      if @recipe.save

        params[:recipe][:steps].each do |key, value|
          step = Step.new(content: value.downcase, recipe_id: @recipe.id)
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
            # need to implement measurement_unit
            ingredient = Ingredient.new(food_id: food.id, measurement_unit: "1" )
          else
            flash[:notice] = "Food not found, Recipe was not created."
            @recipe.destroy
          end

          # !@recipe.ingredients.include?(ingredient)
          if @recipe && ingredient
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
      appliances = Recipe.show_appliances(@recipe)
      unless appliances.any?
        appliances.each { |appliance|
          @recipe.appliances << appliance
        }
      end
  end

  def favorite
    @favorite = Favorite.new(user: current_user, recipe: Recipe.find(params[:id]))
    if @favorite.save
      puts "="*20
      puts "Favorite Successfull"
    else
      puts "="*20
      puts "Favorite Failed"
      puts @favorite.errors.full_messages
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
        puts shoppinglist.errors.full_messages
        puts "="*20
      end
    end
    redirect_to root_path
  end

  def user_made
    history = History.new(user: current_user, recipe: @recipe)
    if history.save
      puts "="*20
      puts "History Saved Successfull"
    else
      puts "="*20
      puts "History Failed to Save"
      puts history.errors.full_messages
    end
    redirect_to root_path
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

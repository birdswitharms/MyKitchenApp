class RecipesController < ApplicationController
  before_action :load_recipe, only: [:show, :review]


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
    arr = [
      "air fryer",
      "bachelor griller",
      "barbecue grill",
      "beehive oven",
      "brasero",
      "brazier",
      "bread machine",
      "burjiko",
      "butane torch",
      "cheesemelter",
      "chocolatera",
      "chorkor oven",
      "clome oven",
      "comal",
      "combi steamer",
      "communal oven",
      "convection microwave",
      "convection oven",
      "corn roaster",
      "crepe maker",
      "deep fryer",
      "earth oven",
      "electric cooker",
      "energy regulator",
      "espresso machine",
      "field kitchen",
      "fire pot",
      "flattop grill",
      "food steamer",
      "fufu machine",
      "halogen oven",
      "haybox",
      "horno",
      "hot box",
      "hot plate",
      "instant pot",
      "kamado",
      "kettle",
      "kitchener range",
      "kujiejun",
      "kyoto box",
      "masonry oven",
      "mess kit",
      "microwave oven",
      "multicooker",
      "oven",
      "pancake machine",
      "panini sandwich grill",
      "popcorn maker",
      "pressure cooker",
      "pressure fryer",
      "reflector oven",
      "remoska",
      "rice cooker",
      "rice polisher",
      "roasting jack",
      "rocket mass heater",
      "rotimatic",
      "rotisserie",
      "russian oven",
      "sabbath mode",
      "salamander broiler",
      "samovar",
      "sandwich toaster",
      "self-cleaning oven",
      "set-n-forget cooker",
      "shichirin",
      "slow cooker",
      "solar cooker",
      "sous-vide cooker",
      "soy milk maker",
      "stove",
      "susceptor",
      "tabun oven",
      "tandoor",
      "tangia",
      "thermal immersion circulator",
      "toaster and toaster ovens",
      "turkey fryer",
      "vacuum fryer",
      "waffle iron",
      "wet grinder",
      "wood-fired oven",
      "coffee percolator",
      "coffeemaker",
      "electric water boiler",
      "instant hot water dispenser"
    ]
    
    @ingredients = load_recipe.ingredients
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
    @favorite = Favorite.new(user: current_user, recipe: Recipe.find(params[:id]))
    if @favorite.save
      puts "="*20
      puts "Favorite Successfull"
    else
      puts "="*20
      puts "Favorite Failed"
    end
  end

  def review
    @review = Review.new(user: current_user, recipe: Recipe.find(params[:id]))
    @review.comment = params[:comment]
    if @review.save
      puts "="*20
      puts "Review Successfull"
      redirect_to recipe_path(@recipe)
    else
      puts "="*20
      puts "Review Failed"
    end
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

require 'uri'

class Recipe < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :have_steps
  validate :have_ingredients

  has_and_belongs_to_many :appliances
  has_and_belongs_to_many :ingredients

  has_many :steps
  has_many :foods, through: :ingredients
  has_many :favorites
  has_many :reviews
  has_many :histories
  has_many :weekly_planners
  belongs_to :user

  def have_steps
    unless steps.any?(&:valid?)
      errors.add(:base, "must have at least one step")
    end
  end

  def have_ingredients
    unless ingredients.any? && ingredients.all?(&:valid?)
      errors.add(:base, "has an invalid ingredient")
    end
  end

  def self.add_recipes(recipe_string = "")

    if recipe_string.blank?
      puts "Please input the name of food as argument"
      return nil
    end

    response_json = requestapi(recipe_string)

    response_json['meals'].each {|recipe|
      next unless recipe
      temp_ingredients = []
      new_recipe = create_recipe(recipe)

      20.times{ |n|
        next if recipe['strMeasure' + (n + 1).to_s].nil?
        next if recipe['strIngredient' + (n + 1).to_s].nil?

        measurement = recipe['strMeasure' + (n + 1).to_s].capitalize
        ingredient = recipe['strIngredient' + (n + 1).to_s].capitalize
        if (measurement == '') || (ingredient == '')
          next
        end
        t = create_ingredient_and_food(n, recipe, measurement, ingredient)
        new_ingredient = t
        temp_ingredients << t
      }

      # new_ingredient.calories = json.asdasd
      response = Ingredient.get_nutrition(temp_ingredients)
      puts "*"*20
      ap "TEMP ingredients length: #{temp_ingredients.length}"
      ap "response foods length: #{response["foods"].length}"
      puts "*"*20
      if temp_ingredients.length == response["foods"].length
        temp_ingredients.each_with_index { |ingredient, index|
          current_food = response["foods"][index]

          measurement_string = current_food["serving_qty"].to_s + " " + current_food["serving_unit"].to_s
          actual_ingredient = Ingredient.find_by(food: ingredient.food, measurement_unit: measurement_string)

          if actual_ingredient
            ingredient = actual_ingredient
          else
            puts "*"*20
            puts "Update ingredient"
            puts "*"*20
            if ingredient.update!(measurement_unit: current_food["serving_qty"].to_s + " " + current_food["serving_unit"].to_s)
            nutrition_details(ingredient, current_food)
              puts "Ingredient Successful"
            else
              puts "Ingredient Failed"
              puts ingredient.errors.full_messages
            end
          end
        }
      else
        fix_ingredients(temp_ingredients, response["foods"])
        puts "*"*20
        puts "PROBLEM WITH API, DOES NOT EQUAL"
        puts "*"*20
      end
      puts "*"*20
      puts "PUSHING TEMP INGREDIENTS TO RECIPE"
      # ap new_recipe.ingredients
      puts "*"*20
      # ap temp_ingredients - new_recipe.ingredients
        # binding.pry
      temp_ingredients.each { |ingredient|
        # ap ingredient
        unless new_recipe.ingredients.include?(ingredient)
          begin
            new_recipe.ingredients << ingredient
          rescue
            puts " Ingredient already exists, skipping temp ingredient "
          end
        end
      }
        # new_recipe.ingredients << (temp_ingredients - new_recipe.ingredients)

      create_appliances(new_recipe)

      if new_recipe.save
        puts "Recipe successful"
      else
        puts "Recipe failed"
        puts new_recipe.errors.full_messages
      end

    }

    return nil
  end

  def self.requestapi(recipe_string)
    url = "https://www.themealdb.com/api/json/v1/1/search.php?s=#{recipe_string}"
    response = HTTParty.get(url)
    return JSON.parse(response.body)
  end

  def self.nutrition_details(ingredient, nutrition_json_ingredient)
    food = nutrition_json_ingredient
    ingredient.calories = food["nf_calories"]
    ingredient.total_fat = food["nf_total_fat"]
    ingredient.saturated_fat = food["nf_saturated_fat"]
    # 404 Json
    # trans_fat = food[""]
    # polyunsaturated_fat = food[""]
    # monounsaturated_fat = food[""]
    ingredient.cholesterol = food["nf_cholesterol"]
    ingredient.sodium = food["nf_sodium"]
    ingredient.potassium = food["nf_potassium"]
    ingredient.total_carbohydrates = food["nf_total_carbohydrate"]
    ingredient.dietary_fiber = food["nf_dietary_fiber"]
    ingredient.sugars = food["nf_sugars"]
    ingredient.protein = food["nf_protein"]

    if ingredient.save
      puts "*"*20
      puts "Nutrition Data for #{ingredient.food.name} saved"
      return true
    else
      puts "*"*20
      puts "Nutrition Data for #{ingredient.food.name} not saved due to: "
      puts ingredient.errors.full_messages
      return false
    end
  end

  def recipe_nutrition_totals
    ingredient_list = self.ingredients.all
    nutrition = {
      calories:            ingredient_list.sum{ |e| e.calories || 0.0},
      total_fat:           ingredient_list.sum{ |e| e.total_fat || 0.0},
      saturated_fat:       ingredient_list.sum{ |e| e.saturated_fat || 0.0},
      cholesterol:         ingredient_list.sum{ |e| e.cholesterol || 0.0},
      sodium:              ingredient_list.sum{ |e| e.sodium || 0.0},
      potassium:           ingredient_list.sum{ |e| e.potassium || 0.0},
      total_carbohydrates: ingredient_list.sum{ |e| e.total_carbohydrates || 0.0},
      dietary_fiber:       ingredient_list.sum{ |e| e.dietary_fiber || 0.0},
      sugars:              ingredient_list.sum{ |e| e.sugars || 0.0},
      protein:             ingredient_list.sum{ |e| e.protein || 0.0}
    }
    return nutrition
  end

  def self.create_recipe(recipe)
    puts "*"*20
    puts "CREATE RECIPE"
    find_recipe = Recipe.find_by_name(recipe['strMeal'].chomp)
    if find_recipe
      new_recipe = find_recipe
    else
      youtube = recipe['strYoutube'].chomp if recipe['strYoutube']
      img = recipe['strMealThumb'].chomp if recipe['strMealThumb']

      begin
        URI.parse(img)
      rescue
        img = ""
      else
        unless URI.parse(img).host && URI.parse(img).path
          img = ""
        end
      end

      new_recipe = Recipe.new(name: recipe['strMeal'].chomp, youtube_url: youtube , image_url: img, user: User.first)
    end


      recipe['strInstructions'].split(/[\r\n]+/).each { |instruction|
        new_recipe.steps.new(content: instruction.downcase)
      }
    return new_recipe
  end

  def self.create_ingredient_and_food(n,recipe, measurement, ingredient)
    puts "*"*20
    puts "CREATE INGREDIENT AND FOOD"
    if Food.find_by(name: ingredient.capitalize.chomp)
      puts "*"*20
      puts "FOUND MATCH"
      new_food = Food.find_by(name: ingredient.capitalize.chomp)
    else
      puts "*"*20
      new_food = Food.new(name: ingredient.capitalize.chomp)
      if new_food.save
        puts "Food Successful"
      else
        puts "Food Failed"
        puts new_food.errors.full_messages
      end
    end
    found = Ingredient.find_by(food: new_food, measurement_unit: measurement.capitalize.chomp )
    if found
      new_ingredient = found
    else
      new_ingredient = Ingredient.new(food: new_food, measurement_unit: measurement.capitalize.chomp )
    end
    puts "*"*20
    puts "PUSHING NEW INGREDIENT TO TEMP"

    return new_ingredient
  end

  def self.create_appliances(new_recipe)
    puts "*"*20
    puts "CREATE APPLIANCES"
    appliances = Recipe.show_appliances(new_recipe)
    if appliances.any?
      puts "APPLIANCES FOUND"
      appliances.each { |appliance|
        appliance.recipes << new_recipe
      }
    else
      puts "APPLIANCES NOT FOUND"
    end
  end

  def self.fix_ingredients(recipe_ingredients, json_foods)
    puts "*"*20
    puts "FIX INGREDIENTS"
    recipe_ingredients.each { |ingredient|
      json_foods.each { |food|
        measurement_string = food["serving_qty"].to_s + " " + food["serving_unit"].to_s
        actual_ingredient = Ingredient.find_by(food: ingredient.food, measurement_unit: measurement_string)
        nutrition_details(ingredient, food)
        if (ingredient.food.name.downcase == food["food_name"].downcase)
          if actual_ingredient
            ingredient = actual_ingredient
            ingredient.save
          else
            puts "*"*20
            puts "Ingredient updates with api"
            puts "*"*20
            if ingredient.update!(measurement_unit: food["serving_qty"].to_s + " " + food["serving_unit"].to_s)
              puts "Ingredient Successful inside fix_ingredients"
            else

              puts "Ingredient Failed inside fix_ingredients"
              puts ingredient.errors.full_messages
            end
          end

          break
        end
      }
    }
  end

  def self.show_appliances(recipe)
    puts "*"*20
    puts "Show Appliances"
    matches = []
    Appliance.all.each { |appliance|
      recipe.steps.each{ |step|
        if step.content.include?(appliance.name.downcase)
          matches << appliance
        end
      }
    }
    puts "*"*20
    puts "MATCHES"
    ap matches
    return matches.uniq
  end

  def add_ingredients(list_of_ingredients = [])
  end

  def add_to_favourites(user)
    favourite = Favourite.new(user: user, recipe: self)
    puts "*"*20
    if favourite.save
      puts "Favourite Successful"
    else
      puts "Favourite Failed"
    end
  end

  def self.find_ingredient(included = [], excluded = [])
    # Recieves array of items items included or excluded
    included.compact!
    excluded.compact!
    recipes = []

    if included.empty?
      recipes_with_included_ingredients = Recipe.all
    else
      included.each { |food|
        recipes << select { |recipe|
          is_included = false
          recipe.foods.map(&:name).each {|fooditem|
            if fooditem.include?(food)
              is_included = true
            end
          }
          is_included
        }
      }
      recipes_with_included_ingredients = recipes.reduce(:|)
    end

    return recipes_with_included_ingredients if excluded.empty?

    recipes = []
    excluded.each { |food|
      recipes << recipes_with_included_ingredients.select { |recipe|
        not_included = true
        recipe.foods.map(&:name).each {|fooditem|
          if fooditem.include?(food)
            not_included = false
          end
        }
        not_included
      }
    }

    return recipes.reduce(:|)
    # recipes = select { |recipe|
    #   (recipe.foods.map(&:name) & included).any?
    # }
    # .select { |recipe|
    #   (recipe.foods.map(&:name) & excluded).empty?
    # }
  end

  def self.add_some_food_shoppinglist(recipe, user)
    foods = []
    recipe.foods.each do |food|
      unless user.foods.include?(food)
        foods << food
      end
    end
    return foods
  end

  def self.valid_recipes_with_pantry(user)
    r = select { |recipe| (recipe.foods - user.foods).empty? }
    ap "*"*20
    ap "Recipes with pantry"
    # ap r
    return r
  end

  def self.valid_recipes_with_appliances(user)
    r = select { |recipe| (recipe.appliances - user.appliances).empty? }
    ap "*"*20
    ap "Recipes with appliances"
    # ap r
    return r
  end

  def self.valid_recipes_partial(user)
    r = select { |recipe| (recipe.foods & user.foods).any? }
    ap "*"*20
    ap "Recipes with appliances"
    # ap r
    return r
  end
end

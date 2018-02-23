class Recipe < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :appliances
  has_and_belongs_to_many :ingredients

  has_many :steps
  has_many :foods, through: :ingredients
  has_many :favorites
  has_many :reviews
  has_many :appliances_recipes
  has_many :histories

  def self.add_recipes()
    url = 'https://www.themealdb.com/api/json/v1/1/search.php?s=beef'
    response = HTTParty.get(url)
    response_json = JSON.parse(response.body)
    response_json['meals'].each {|recipe|
      new_recipe = Recipe.new(name: recipe['strMeal'].chomp, youtube_url: recipe['strYoutube'].chomp, image_url: recipe['strMealThumb'].chomp)

      if new_recipe.save
        puts "Recipe Successful"
        recipe['strInstructions'].split(/[\r\n]+/).each { |instruction|
          step = Step.new(content: instruction.downcase, recipe_id: new_recipe.id)
          puts "*"*20
          if step.save
            puts "Step Successful"
          else
            puts "Step Failed"
          end
        }
      else
        puts "Recipe Failed"
        puts new_recipe.errors.full_messages
      end

      20.times{ |n|
        measurement = recipe['strMeasure' + (n + 1).to_s].capitalize
        ingredient = recipe['strIngredient' + (n + 1).to_s].capitalize
        if (measurement == '') || (ingredient == '')
          next
        end

        new_food = Food.new(name: ingredient.capitalize.chomp)
        matched_food = Food.find_by(name: new_food.name)

        if matched_food
          puts "*"*20
          puts "FOUND MATCH"
          new_food = matched_food
        else
          puts "*"*20
          if new_food.save
            puts "Food Successful"
          else
            puts "Food Failed"
            puts new_food.errors.full_messages
          end
        end

        new_ingredient = Ingredient.new(food_id: new_food.id, measurement_unit: measurement.capitalize.chomp )

        if new_ingredient.save
          puts "Ingredient Successful"
        else
          puts "Ingredient Failed"
          puts new_ingredient.errors.full_messages
        end

        new_recipe.ingredients << new_ingredient
        # make sure if ingredient is not saved, then we search for that ingredient and use it in recipe
      }
      appliances = Recipe.show_appliances(new_recipe)
      unless appliances.any?
        appliances.each { |appliance|
          new_recipe.appliances << appliance
        }
      end
    }
    return nil
  end

  def self.show_appliances(recipe)
    # recipe.steps
    # Recipe.first << Appliance.first
    matches = []
    Appliance.all.each { |appliance|
      steps = recipe.steps.where("content LIKE (?)", "%#{appliance.name}%")
      if steps.any?
        steps.each { |step|
          matches << appliance
        }
      end
    }
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
    ap r
    return r
  end

  def self.valid_recipes_with_appliances(user)
    r = select { |recipe| (recipe.appliances - user.appliances).any? }
    ap "*"*20
    ap "Recipes with appliances"
    ap r
    return r
  end
end

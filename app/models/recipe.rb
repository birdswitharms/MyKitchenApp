class Recipe < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :ingredients
  has_many :steps
  has_many :foods, through: :ingredients
  has_many :favorites

  def self.add_recipes()
    url = 'https://www.themealdb.com/api/json/v1/1/search.php?s=pork'
    response = HTTParty.get(url)
    response_json = JSON.parse(response.body)

    response_json['meals'].each {|recipe|
      new_recipe = Recipe.new(name: recipe['strMeal'], youtube_url: recipe['strYoutube'], image_url: recipe['strMealThumb'])

      puts "*"*20
      if new_recipe.save
        puts "Recipe Successful"

        recipe['strInstructions'].split(/[\r\n]+/).each { |instruction|
          step = Step.new(content: instruction, recipe_id: new_recipe.id)
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

        new_food = Food.new(name: ingredient)

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

          new_ingredient = Ingredient.new(food_id: new_food.id, measurement_unit: measurement )

        puts "*"*20
        if new_ingredient.save
          puts "Ingredient Successful"
        else
          puts "Ingredient Failed"
          puts new_ingredient.errors.full_messages
        end

        new_recipe.ingredients << new_ingredient

        # make sure if ingredient is not saved, then we search for that ingredient and use it in recipe
      }
    }
    return nil
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

  def find_ingredient


  end

  def self.valid_recipes_with_pantry(user)
    select { |recipe| (recipe.foods - user.foods).empty? }
  end
end

class Recipe < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :ingredients
  has_many :steps
  has_many :foods, through: :ingredients
  has_many :favorites

  def self.add_recipes()
    # Set env variable using example api_key from wordnik website
    # auth_key = {api_key: "#{ENV['TEMP_WORDNIK_KEY']}"}
    # response = HTTParty.get('http://api.wordnik.com:80/v4/words.json/randomWords?limit=10', headers: auth_key )
    url = 'http://www.themealdb.com/api/json/v1/1/search.php?s=chicken'
    response = HTTParty.get(url)
    response_json = JSON.parse(response.body)

    response_json['meals'].each {|recipe|
      # ap recipe
      new_recipe = Recipe.new(name: recipe['strMeal'], youtube_url: recipe['strYoutube'], image_url: recipe['strMealThumb'])

      puts "*"*20
      if new_recipe.save
        puts "Recipe Successful"
      else
        puts "Recipe Failed"
        puts new_recipe.errors.full_messages
      end

      20.times{ |n|
        measurement = recipe['strMeasure' + (n + 1).to_s].capitalize
        ingredient = recipe['strIngredient' + (n + 1).to_s].capitalize
        # binding.pry
        if (measurement == '') || (ingredient == '')
          next
        end

        # if measurement == 'pinch'
        #   measurement.unshift(1)
        # end

        new_food = Food.new(name: ingredient)

        matched_food = Food.find_by(name: new_food.name)
        # binding.pry
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

        # if measurement.count >= 2
        #   new_ingredient = Ingredient.new(food_id: new_food.id, quantity: measurement[0], measurement_unit: measurement[1] )
          new_ingredient = Ingredient.new(food_id: new_food.id, measurement_unit: measurement )


        puts "*"*20
        if new_ingredient.save
          puts "Ingredient Successful"
        else
          puts "Ingredient Failed"
          puts new_ingredient.errors.full_messages
        end

        new_recipe.ingredients << new_ingredient
        # puts measurement + ' ' + ingredient

        # make sure if ingredient is not saved, then we search for that ingredient and use it in recipe
      }
      # new_recipe.ingredients <<
    }
    return nil
  end

  def add_ingredients(list_of_ingredients = [])
    #
    # # Set env variable using example api_key from wordnik website
    # # auth_key = {api_key: "#{ENV['TEMP_WORDNIK_KEY']}"}
    # url = 'http://www.recipepuppy.com/api/?i=avocado,toast&p=1&q:avocado+toast'
    # response = HTTParty.get(url)
    # # response = HTTParty.get('http://api.wordnik.com:80/v4/words.json/randomWords?limit=10', headers: auth_key )
    # response_json = JSON.parse(response.body)
    #
    # response_json['results'].each {|recipe|
    #   ap recipe
    # }

  end

  def self.valid_recipes_with_pantry(user)
    # recipe_foods = Recipe.first.ingredients.map(&:food).pluck(:name)
    # Recipe.first.ingredients.includes(:food).pluck(:name)
    # binding.pry
    # all.each { |recipe|
    #   Recipe.all.where()
    # }
    # all.select { |recipe| (recipe.foods - user.foods).empty? }
    select { |recipe| (recipe.foods - user.foods).empty? }
  end
end

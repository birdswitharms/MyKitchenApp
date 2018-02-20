class Recipe < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :ingredients
  has_many :steps

  def self.add_recipes()

    # Set env variable using example api_key from wordnik website
    # auth_key = {api_key: "#{ENV['TEMP_WORDNIK_KEY']}"}
    # response = HTTParty.get('http://api.wordnik.com:80/v4/words.json/randomWords?limit=10', headers: auth_key )

    url = 'http://www.themealdb.com/api/json/v1/1/search.php?s=avocado'
    response = HTTParty.get(url)
    response_json = JSON.parse(response.body)

    response_json['meals'].each {|recipe|
      # ap recipe

      new_recipe = Recipe.new(name: recipe['strMeal'])
      new_recipe.save

      20.times{ |n|
        measurement = recipe['strMeasure' + (n + 1).to_s].split(' ')
        ingredient = recipe['strIngredient' + (n + 1).to_s]

        if (measurement == '') || (ingredient == '')
          break
        end

        new_food = Food.new(name: ingredient)

        matched_food = Food.find_by(name: new_food.name)

        if matched_food && matched_food.any?
          new_food = matched_food
        else
          new_food.save
        end

        if measurement.count >= 2
          new_ingredient = Ingredient.new(food_id: new_food.id, quantity: measurement[0], measurement_unit: measurement[1] )
        else
          new_ingredient = Ingredient.new(food_id: new_food.id, quantity: measurement[0], measurement_unit: 'whole' )
        end

        new_ingredient.save
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
end

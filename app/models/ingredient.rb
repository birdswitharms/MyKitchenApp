class Ingredient < ApplicationRecord
  validates :food, presence: true
  validates :measurement_unit, presence: true
  # add later
  # validates :quantity, presence: true, numericality: true
  validates :food_id, uniqueness: { scope: [:measurement_unit] }

  has_and_belongs_to_many :recipes
  belongs_to :food

  def self.get_nutrition(ingredients = [])
    return nil if ingredients.empty?
    url = 'https://trackapi.nutritionix.com/v2/natural/nutrients'
    nutritionix_id = {"x-app-id": "#{ENV['NUTRITIONIX_ID']}"}
    nutritionix_key = {"x-app-key": "#{ENV['NUTRITIONIX_KEY']}"}

    query = []
    ingredients.each { |ingredient|
      query << ingredient.measurement_unit + " " + ingredient.food.name
    }

    remove_words = [
      "chopped",
      "sliced",
      "diced"
    ]

    query.map! { |string|
      r = ""
      remove_words.each { |word|
        if string.downcase.include?(word)
          r = string.delete(word).gsub("  ", " ")
        else
          r = string
        end
      }
      r
    }
    response = HTTParty.post(url,
    :body => {
      "query": query.join(", "),
      "timezone": "US/Eastern"
    }.to_json,
    :headers => { 'Content-Type' => 'application/json' }.merge(nutritionix_id).merge(nutritionix_key) )

    response_json = JSON.parse(response.body)
    # puts "*"*20
    # puts "JSON RESPONSE:"
    # ap response_json
    # puts "*"*20

    return response_json
    # response_json['meals'].each {|recipe|
  end
end

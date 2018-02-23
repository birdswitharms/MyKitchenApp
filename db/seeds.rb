# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# -- Reset Setup --
# Recipe.destroy_all
# Food.destroy_all
# Ingredient.destroy_all
# Category.destroy_all
# User.destroy_all
# -- User Setup --
User.create(name: "a", email: "a@a.com", password: "1234", password_confirmation: "1234")
# -- Categories Setup --
# Category.create(name: "Meat") # 1
# Category.create(name: "Vegtables") # 2
# Category.create(name: "Fruits") # 3
# Category.create(name: "Spices") # 4
# Category.create(name: "Condiments") # 5
# Category.create(name: "Dairy") # 6
# Category.create(name: "Baking") # 7
# Category.create(name: "Canned Goods") # 8
# Category.create(name: "Dried Goods") # 9
# Category.create(name: "Grains") # 10
# -- Food Setup --
# #
# Food.create(name: "chicken breast", category_id: 1)
# Food.create(name: "chicken thighs", category_id: 1)
# Food.create(name: "chicken wings", category_id: 1)
# Food.create(name: "whole turkey", category_id: 1)
# Food.create(name: "whole chicken", category_id: 1)
# Food.create(name: "brisket", category_id: 1)
# Food.create(name: "veal", category_id: 1)
# Food.create(name: "ground veal", category_id: 1)
# Food.create(name: "ground beef", category_id: 1)
# Food.create(name: "ground turkey", category_id: 1)
# Food.create(name: "steak", category_id: 1)
# Food.create(name: "cucumber", category_id: 2)
# Food.create(name: "bell pepper", category_id: 2)
# Food.create(name: "carrot", category_id: 2)
# Food.create(name: "lettuce", category_id: 2)
# Food.create(name: "celary", category_id: 2)
# Food.create(name: "spinach", category_id: 2)
# Food.create(name: "zucchini", category_id: 2)
# Food.create(name: "eggplant", category_id: 2)
# Food.create(name: "tomatoe", category_id: 2)
# Food.create(name: "squash", category_id: 2)
# Food.create(name: "onions", category_id: 2)
# Food.create(name: "ginger root", category_id: 2)
# Food.create(name: "turnip", category_id: 2)
# Food.create(name: "potatoes", category_id: 2)
# Food.create(name: "raddish", category_id: 2)
# Food.create(name: "watermelon", category_id: 3)
# Food.create(name: "apple", category_id: 3)
# Food.create(name: "orange", category_id: 3)
# Food.create(name: "avocado", category_id: 3)
# Food.create(name: "parsley", category_id: 4)
# Food.create(name: "garlic", category_id: 4)
# Food.create(name: "egg", category_id: 6)
# Food.create(name: "bread", category_id: 10)
# -- Ingredient Setup --
# Ingredient.create(food_id: 30, quantity: 1, measurement_unit: "whole")
# Ingredient.create(food_id: 34, quantity: 2, measurement_unit: "slices")
# -- Recipe Setup --
# Recipe.create(name: "Avocado toast")
# Recipe.find(1).ingredients << Ingredient.find(1)
# Recipe.find(1).ingredients << Ingredient.find(2)

appliances = [
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
  "instant hot water dispenser",
  "pan",
  "pot",
  "wok",
  "grill",
  "stick blender",
  "food processor"
]
# appliances.each { |appliance|
#   Appliance.create(name: appliance)
# }

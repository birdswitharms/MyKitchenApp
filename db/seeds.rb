# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# -- Delete Setup --
Recipe.delete_all
Food.delete_all
Ingredient.delete_all

# -- Recipe Setup --
Recipe.create(name: "Avocado toast", calories: 272)
Recipe.create(name: "Avocado toast with Egg", calories: 342)

# -- Food Setup --
Food.create(name: "Avocado")
Food.create(name: "Bread")
Food.create(name: "Egg")


# -- Ingredients Setup --
Recipe.find_by(name: "Avocado toast").foods << Food.find_by(name: "Avocado")
Recipe.find_by(name: "Avocado toast").foods << Food.find_by(name: "Bread")

Recipe.find_by(name: "Avocado toast with Egg").foods << Food.find_by(name: "Avocado")
Recipe.find_by(name: "Avocado toast with Egg").foods << Food.find_by(name: "Bread")
Recipe.find_by(name: "Avocado toast with Egg").foods << Food.find_by(name: "Egg")

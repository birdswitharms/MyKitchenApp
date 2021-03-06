# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180226165730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appliances", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appliances_recipes", force: :cascade do |t|
    t.integer "appliance_id"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appliance_id"], name: "index_appliances_recipes_on_appliance_id"
    t.index ["recipe_id"], name: "index_appliances_recipes_on_recipe_id"
  end

  create_table "appliances_users", force: :cascade do |t|
    t.integer "appliance_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appliance_id"], name: "index_appliances_users_on_appliance_id"
    t.index ["user_id"], name: "index_appliances_users_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_favorites_on_recipe_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
  end

  create_table "histories", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_histories_on_recipe_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer "food_id"
    t.string "measurement_unit"
    t.float "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "calories"
    t.float "total_fat"
    t.float "saturated_fat"
    t.float "cholesterol"
    t.float "sodium"
    t.float "potassium"
    t.float "total_carbohydrates"
    t.float "dietary_fiber"
    t.float "sugars"
    t.float "protein"
    t.index ["food_id"], name: "index_ingredients_on_food_id"
  end

  create_table "ingredients_recipes", force: :cascade do |t|
    t.integer "ingredient_id"
    t.integer "recipe_id"
  end

  create_table "pantries", force: :cascade do |t|
    t.integer "food_id"
    t.integer "user_id"
    t.index ["food_id"], name: "index_pantries_on_food_id"
    t.index ["user_id"], name: "index_pantries_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image_url"
    t.text "youtube_url"
    t.integer "user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "user_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_reviews_on_recipe_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shoppinglists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "food_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_shoppinglists_on_food_id"
    t.index ["user_id"], name: "index_shoppinglists_on_user_id"
  end

  create_table "steps", force: :cascade do |t|
    t.text "content"
    t.integer "recipe_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

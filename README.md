# My Kitchen App
  * My Kitchen App is not a unique app, but it showcases the many skills and technologies we learned while learning web development at Bitmaker Labs for 3 months as full-time students learning to become full-stack developers.

  * My Kitchen App uses Ruby on Rails and Postgres for the back-end
  * A small amount of jQuery and Ajax, with a lot of vanilla JavaScript and CSS for the front-end
  * The recipes are pulled from an API (themealdb), where we take that JSON data and save it to our database, and parse it to create the ingredients and food for our Application.
  * We then send the ingredients for each recipe through another API (nutrionix) to calculate the total calories that recipe generates.

***  


# MVP (Minimal Viable Product)

* As a visitor I am allowed to sign up and login - DONE
* As a visitor I am allowed to see all recipes - DONE
* As a visitor I can visit each recipe page and show details about that recipe - DONE

* As a user I can save ingredients to 'My Kitchen' - DONE
* As a user the recipe index only shows recipes based on 'My Kitchen' ingredients - DONE
* As a user I can CRUD recipes that I own - DONE


# Want to have

* As a visitor I am able to search for recipes by name - DONE
* As a visitor I am able to search for recipes with/without certain ingredients - DONE
* As a visitor I can see nutritional information for the recipe - DONE

* As a user I can check off what appliances I have in 'My Kitchen' - DONE
* As a user I can write a review for a recipe - DONE
* As a user I can save recipes - DONE
* As a user I can save the foods from a recipe into my shopping list - DONE

# Nice to have

* As a visitor I am able to view profiles and see recipes owned by that user - DONE

* As a user I can see a history of recipes I cooked - DONE
* As a user, when I complete a recipe I cooked, it should ask the user to manually update 'My Kitchen' - DONE

***

# AFTER DUE | To-Do List

* As a user I can edit an existing recipe and make it my own custom recipe - DROPPED
* As a user I can plan my recipes for the week - DROPPED
* As a visitor I am able to see similar recipes on the recipe details page - DROPPED
* As a visitor I am able to search by calories per serving - DROPPED
* As a visitor I can change how much of the recipe I want to create and will update the ingredients accordingly - DROPPED
* As a visitor I am able to select the measurement unit I want on the recipe page - DROPPED
* As a user when I add a food to my kitchen, it is separated by category - DROPPED
* As a visitor I am able to search by category - DROPPED


# Fine Tuning

* Create recipe form - food is always under input form even if you add a step/works for multiple ingredients
* Display the user who created the recipe in the show page (and link to profile)
* Ajax call for desktop version of reviews post (user name should link to profile)
* Update mobile review call to link to user profile
* Profile page have more information? (ex. Name, Age?, Location?, Profile Picture, Description?, Twitter/Facebook/Instagram?)


# PRIORITY List - Features

* As a user I can plan my recipes for the week - ANDREW
* As a visitor I am able to search by calories per serving
* As a visitor I can change how much of the recipe I want to create and will update the ingredients accordingly
* As a user I can edit an existing recipe and make it my own custom recipe

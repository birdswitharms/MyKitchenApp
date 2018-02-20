document.addEventListener('DOMContentLoaded', function(e){

  var step_counter = 2;
  var ingredient_counter = 2;
  var step_button = document.getElementById('add-step-button');
  var step_div = document.getElementById('step-div');
  var ingredient_button = document.getElementById('add-ingredient-button');
  var ingredient_div = document.getElementById('ingredient-div');

  step_button.addEventListener('click', function() {
    var step_field = document.createElement('input');
    step_field.type = "textarea";
    step_field.name = "recipe[steps]["+step_counter+"]";
    step_field.id = "step"+step_counter;
    var p = document.createElement('p');
    p.innerText = "Step "+step_counter+" :";
    step_counter++;
    step_div.append(p);
    p.append(step_field);
  });

  ingredient_button.addEventListener('click', function() {
    var ingredient_field = document.createElement('input');
    ingredient_field.type = "textarea";
    ingredient_field.name = "recipe[ingredient]["+ingredient_counter+"]";
    ingredient_field.id = "ingredient"+ingredient_counter;
    var p = document.createElement('p');
    p.innerText = "Ingredient "+ingredient_counter+" :";
    ingredient_counter++;
    ingredient_div.append(p);
    p.append(ingredient_field);
  });



});

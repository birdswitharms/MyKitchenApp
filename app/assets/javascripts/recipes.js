document.addEventListener('DOMContentLoaded', function(e){

  var step_counter = 2;
  var ingredient_counter = 2;
  var step_button = document.getElementById('add-step-button');
  var step_div = document.getElementById('step-div');
  var ingredient_button = document.getElementById('add-ingredient-button');
  var ingredient_div = document.getElementById('ingredient-div');
  var include_ingredient_div = document.getElementById('include-ingredient-div');
  var exclude_ingredient_div = document.getElementById('exclude-ingredient-div');
  var include_ingredient_button = document.getElementById('include-ingredient-button');
  var exclude_ingredient_button = document.getElementById('exclude-ingredient-button');

if (step_button && ingredient_button) {

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
}

if (include_ingredient_button && exclude_ingredient_button) {

  include_ingredient_button.addEventListener('click', function() {
    var step_field = document.createElement('input');
    step_field.type = "textarea";
    step_field.name = "recipe[ingredient]["+step_counter+"]";
    step_field.id = "include-ingredient"+step_counter;
    var p = document.createElement('p');
    step_counter++;
    include_ingredient_div.append(p);
    p.append(step_field);
  });

  // exclude_ingredient_button.addEventListener('click', function() {
  //   var step_field = document.createElement('input');
  //   step_field.type = "textarea";
  //   step_field.name = "recipe[ingredient]["+step_counter+"]";
  //   step_field.id = "exclude-ingredient"+step_counter;
  //   var p = document.createElement('p');
  //   step_counter++;
  //   exclude_ingredient_div.append(p);
  //   p.append(step_field);
  // });


}

// link = 'http://www.recipepuppy.com/api/?i=avocado,toast&p=1&q:avocado+toast'
// $.ajax({
//       url: link,
//       method: 'GET',
//       dataType: 'JSON'
//     }).done(function(response) {
//         // roboDetails.innerHTML = response;
//         // roboDetails.innerHTML = '';
//         // // console.log(response);
//         // var div = document.createElement('div');
//         // var img = document.createElement('img');
//         // img.src = 'http://robohash.org/' + response.address;
//         // var p = document.createElement('p');
//         // p.innerText = response.name;
//         //
//         // div.append(img);
//         // div.append(p);
//         // roboDetails.append(div);
//
//         var source   = document.getElementById("entry-template").innerHTML;
//         var template = Handlebars.compile(source);
//
//         roboDetails.innerHTML = template(response);
//     });

});

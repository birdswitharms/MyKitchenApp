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
  var hamburger = document.getElementById('hamburger');
  var menu = document.querySelector('.menu');
  var bottom_button = document.getElementById('button');
  var bottom_menu = document.querySelector('.bottom_menu');
  var review_button_menu = document.getElementById('review_button_menu');
  if (document.getElementById('recipe_id')) {
    var hidden_recipe_id = document.getElementById('recipe_id').value

  }
  var review_text = document.getElementById('review_text')
  var review_close = document.getElementById('review_close');
  var submit_review = document.getElementById('submit_review');

  if (review_close) {
    review_close.addEventListener('click', function(event) {

      review_text.classList.toggle("hidden");
      $('body').removeClass('stop-scrolling')
    });
  };

  if (submit_review) {
    submit_review.addEventListener('submit', function() {
      event.preventDefault();
      $.ajax({
        url: '/recipes/'+hidden_recipe_id,
        method: 'GET',
        dataType: 'json'
      }).done(function(responseData) {
        console.log(responseData);
      }).fail(function(_jqXHR, textStatus, errorThrown) {

      });
    });
  };

  if (review_button_menu) {
    review_button_menu.addEventListener('click', function(event) {
      event.preventDefault();
      review_text.classList.toggle("hidden");
      $('body').addClass('stop-scrolling')
    });
  };

  if (hamburger) {
    hamburger.addEventListener('click', function() {
      hamburger.classList.toggle("is-active");
      menu.classList.toggle("menu_show");
    });
  };

  if (bottom_button) {
    bottom_button.addEventListener('click', function() {
      bottom_menu.classList.toggle("bottom_menu_show")
    });
  };

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
  };

  if (include_ingredient_button && exclude_ingredient_button) {

    include_ingredient_button.addEventListener('click', function() {
      var step_field = document.createElement('input');
      step_field.type = "textarea";
      step_field.name = "include["+step_counter+"]";
      step_field.id = "include-ingredient"+step_counter;
      var p = document.createElement('p');
      step_counter++;
      include_ingredient_div.append(p);
      p.append(step_field);
    });

    exclude_ingredient_button.addEventListener('click', function() {
      var step_field = document.createElement('input');
      step_field.type = "textarea";
      step_field.name = "exclude["+ingredient_counter+"]";
      step_field.id = "exclude-ingredient"+ingredient_counter;
      var p = document.createElement('p');
      ingredient_counter++;
      exclude_ingredient_div.append(p);
      p.append(step_field);
    });
  };

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

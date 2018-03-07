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
  };
  var review_text = document.getElementById('review_text');
  var review_close = document.getElementById('review_close');
  var submit_review = document.getElementById('submit_review');
  var review_form = document.getElementById('review_form');
  var review_div = document.querySelector('.reviews-div');
  var measurements = ['a whole', 'a half', '1/8 teaspoon', '1/4 teaspoon', '1/2 teaspoon', 'teaspoon', '1/8 tablespoon', '1/4 tablespoon', '1/2 tablespoon', 'tablespoon', '1/8 cup', '1/4 cup', '1/2 cup', 'cup', '1/4 pint', '1/2 pint', 'pint', '1/4 gallon', '1/2 gallon', 'gallon', 'fluid ounce', '1/4 quart', '1/2 quart', 'quart', '1/4 liter', '1/2 liter', 'liter', 'ounce', 'grams', 'lbs', 'kgs'];
  var initial_select = document.getElementById('initial_select');

  if (initial_select) {
    initial_select.style.width = '90px';
  }

  if (initial_select) {
    for (var i = 0; i < measurements.length; i++) {
      var opt = measurements[i];
      var el = document.createElement("option");
      el.textContent = opt;
      el.value = opt;

      initial_select.appendChild(el);
    }
  }


  if (review_div && review_div.innerHTML.trim()) {
    review_div.classList.remove("hide");
  };

  if (review_close) {
    review_close.addEventListener('click', function(event) {
      review_text.classList.toggle("hidden");
      $('body').removeClass('stop-scrolling')
    });
  };

  if (submit_review) {
    submit_review.addEventListener('click', function(event) {
      event.preventDefault();
      $.ajax({
        url: '/recipe/'+hidden_recipe_id+'/review',
        method: 'POST',
        data: $(review_form).serialize(),
        dataType: 'JSON'
      }).done(function(responseData) {
        var reviewName = document.createElement('p');
        var reviewComment = document.createElement('p');
        var reviewTime = document.createElement('p');
        reviewName.innerText = responseData.user_name + ' says...'
        reviewComment.innerText = '\"'+responseData.comment+'\"'
        reviewTime.innerText = responseData.time
        reviewTime.classList.add('review_time');
        review_div.append(reviewName)
        review_div.append(reviewComment)
        review_div.append(reviewTime)
        review_text.classList.toggle("hidden");
        $('body').removeClass('stop-scrolling')
      }).fail(function(_jqXHR, textStatus, errorThrown) {
        console.log('error: ' + errorThrown);
        console.log('textStatus: ' + textStatus);
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
      var measurement_field = document.createElement('input');
      var measurement_select = document.createElement('select');

      ingredient_field.type = "textarea";
      measurement_field.type = "number";
      ingredient_field.name = "recipe[ingredient]["+ingredient_counter+"]";
      measurement_field.name = "recipe[measurement]["+ingredient_counter+"]";
      ingredient_field.id = "ingredient"+ingredient_counter;
      ingredient_field.placeholder = "ex. Chicken"
      ingredient_field.classList.add("ingredient_search_input")
      // ingredient_field.style.width = "132px"
      ingredient_field.autocomplete = "off";
      measurement_field.id = "measurement"+ingredient_counter;
      var p = document.createElement('p');
      p.innerText = "Ingredient "+ingredient_counter+": ";
      ingredient_counter++;
      ingredient_div.append(p);
      var cln = initial_select.cloneNode(true);
      cln.name = "measurement_select_"+(ingredient_counter-1)
      p.append(measurement_field);
      p.append(" ");
      p.append(cln);
      p.append(" ");
      p.append(ingredient_field);
      // ingredient_div.append(p);

      ingredient_field.addEventListener('blur', addBlur);
      ingredient_field.addEventListener('focus', addFocus);
      // searcher(document);
      return
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

});

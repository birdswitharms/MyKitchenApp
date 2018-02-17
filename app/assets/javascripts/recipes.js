document.addEventListener('DOMContentLoaded', function(){

  var count = 2;
  var add_step_button = document.getElementById('add-step-button');
  var step_div = document.getElementById('step-div');

  add_step_button.addEventListener('click', function() {
    var step_field = document.createElement('input');
    step_field.type = "textarea";
    step_field.name = "recipe[steps]["+count+"]";
    step_field.id = "step"+count;
    var p = document.createElement('p');
    p.innerText = "Step "+count+" :"
    count++;
    step_div.append(p);
    p.append(step_field);





  });

});

document.addEventListener('DOMContentLoaded', function(){
  var counter = 10;
  const re = /(\d+)\./;
  const mealslots = document.querySelectorAll('.ui-widget-header');
  const weeklyplanners = document.querySelectorAll('.ui-widget-content');
  const plusButton = document.querySelectorAll('#plus_button');
  const weeklyplannerForm = document.querySelector('#planner_form');

  mealslots.forEach(slot => {
    slot.addEventListener('change', function(event){
      // console.log(event);
      // console.log(event.toElement.children[0].name);
      // console.log(`planner[${event.target.children[0].name}][${event.toElement.innerText}]`);

      if (event.toElement.children[0].value !== event.target.children[0].name) {
        event.toElement.children[0].value = event.target.children[0].name
        console.log(event.toElement.children[0]);
        // event.toElement.children[0].name = `planner[${event.target.children[0].name}][${event.toElement.innerText}]`;

        // console.log('planner # after: '+event.toElement.children[0].value); // droppable recipe
      }
    })
  })

// makes objects droppable
  $(function(event) {
    $( ".recipedroppable" ).draggable({

    });
    $( ".ui-widget-header" ).droppable({
      drop: function(event, ui) {
          $(this).addClass("ui-state-highlight")
          // console.log(event);
          // console.log('mealslot # : '+event.target.children[0].name); // mealslot
          // console.log('planner #: '+event.toElement.children[0].value); // droppable recipe
          var innerText = event.toElement.innerText
          var newText = innerText.substring(0, innerText.length - 2)
          // console.log(newText);
          if (event.toElement.children[0].value !== event.target.children[0].name) {
            event.toElement.children[0].value = event.target.children[0].name
            event.toElement.children[0].name = `planner[${event.target.children[0].name}][${newText}]`;
          }
        }
    });
  });
// check current weekly_planners day/position within the object
weeklyplanners.forEach(planner => {
  mealslots.forEach((slot, i) => {
    // console.dir(mealslots[i]);
    if (planner.children[0].value === mealslots[i].children[0].id) { // checks to see if mealslot and weekly planner position is the same
      const right = mealslots[i].getBoundingClientRect().x;
      const top = mealslots[i].getBoundingClientRect().y;
      planner.style.left = `${right}px`;
      planner.style.top = `${top}px`;
      $(mealslots[i]).addClass("ui-state-highlight")
    }
  });
});

if (plusButton) {
  plusButton.forEach(button => {
    button.addEventListener('click', addEvents);
  });
}

function addEvents() {
    var clone = this.offsetParent.cloneNode();
    var text = this.offsetParent.firstChild.cloneNode();
    var hiddenInput = this.offsetParent.children[0].cloneNode();
    var plusButtonParent = this.offsetParent.children[1].cloneNode();
    plusButtonParent.addEventListener('click', addEvents);
    plusButtonParent.innerText = this.offsetParent.children[1].innerText
    clone.appendChild(text);
    clone.appendChild(hiddenInput);
    clone.appendChild(plusButtonParent);

    // console.log(clone.style.left);
    // console.log(parseInt(clone.style.left) + 10);

    // clone.style.top = `${parseInt(re.exec(clone.style.top)) + 10}px`;
    clone.style.top = `${parseInt(clone.style.top) + 10}px`;

    // clone.style.left = `${parseInt(re.exec(clone.style.left)) + 10}px`;
    clone.style.left = `${parseInt(clone.style.left + 10) + 10}px`;

    weeklyplannerForm.appendChild(clone);
    $(function(event) {
      $( ".recipedroppable" ).draggable({
        drop: function(event, ui) {
            $(this).addClass("ui-state-highlight")
            // console.log(event);
            // console.log('mealslot # : '+event.target.children[0].name); // mealslot
            // console.log('planner #: '+event.toElement.children[0].value); // droppable recipe
            if (event.toElement.children[0].value !== event.target.children[0].name) {
              event.toElement.children[0].value = event.target.children[0].name
              event.toElement.children[0].name = `planner[${event.target.children[0].name}][${newText}]`;
            }
          }
        });
      });
    };






});

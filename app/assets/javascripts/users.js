document.addEventListener('DOMContentLoaded', function(){

  const mealslots = document.querySelectorAll('.ui-widget-header');
  const weeklyplanners = document.querySelectorAll('.ui-widget-content');

  $(function(event) {
    $( ".recipedroppable" ).draggable({

    });
    $( ".ui-widget-header" ).droppable({
      drop: function(event, ui) {
          $(this).addClass("ui-state-highlight")
          // console.log(this.lastChild.id);
      }
    });
  });
// check current weekly_planners day/position within the object



// for each with index



// add event listeners for a 'drop event'

weeklyplanners.forEach(planner => {
  mealslots.forEach((slot, i) => {
    // console.dir(mealslots[i]);
    if (planner.children[0].value === mealslots[i].children[0].id) {
      const right = mealslots[i].getBoundingClientRect().x;
      const top = mealslots[i].getBoundingClientRect().y;
      planner.style.left = `${right}px`;
      planner.style.top = `${top}px`;
      $(mealslots[i]).addClass("ui-state-highlight")
    }

  });

  // console.dir(planner.children[0].value);
  // console.log(mealslots[index].children);

});



});

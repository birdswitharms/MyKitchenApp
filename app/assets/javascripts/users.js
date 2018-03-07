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

  mealslots.forEach(slot => {
    console.dir(slot.children[0].id);
  });

// add event listeners for a 'drop event'

weeklyplanners.forEach(planner => {
  // console.dir(planner.children[0].value);

});



});

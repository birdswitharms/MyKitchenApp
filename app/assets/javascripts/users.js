document.addEventListener('DOMContentLoaded', function(){

  $( function() {
    $( ".recipedroppable" ).draggable({
      snap: '.ui-widget-header'
    });
    $( ".breakfast, .lunch, .dinner" ).droppable({
      
      });
    } );








});

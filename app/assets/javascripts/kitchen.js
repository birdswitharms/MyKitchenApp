var currentMatches = false;

document.addEventListener('DOMContentLoaded', function(e){

  var pantryFormEle = document.querySelector('#pantry_form');
  var withinIngredientSearch = false;
  var searchContainerDiv = false;

  if (pantryFormEle) {
    var ingredientList = []
    var ingredientsNodes = document.querySelectorAll("label");
    var ingredientSearchEle = document.querySelector("#ingredient_search");
    // console.log(ingredientSearchEle);
    ingredientSearchEle.style.width = '250px';
    // console.log("Width is: " + ingredientSearchEle.style.width);

    for (var i = 0; i < ingredientsNodes.length; i++) {
      ingredientList.push(ingredientsNodes[i].innerText);
    }
    // console.log(ingredientList);
    // check first if search is focused
    ingredientSearchEle.addEventListener('focus', function(e) {
      withinIngredientSearch = true;
    });
    ingredientSearchEle.addEventListener('blur', function(e) {
      withinIngredientSearch = false;
    });

    // every key press runs new search
    window.addEventListener('keydown', function(e){
      if (withinIngredientSearch) {
        if (e.key === 'Backspace') {
          currentMatches = search(ingredientSearchEle.value.slice(0,-1), ingredientList)
        }
        else {
          currentMatches = search(ingredientSearchEle.value + e.key, ingredientList)
        }
      }
      if (!searchContainerDiv) {
        searchContainerDiv = document.createElement('div');
        searchContainerDiv.style.position = 'absolute';
        // console.log(searchContainerDiv.parentElement.style.position);
        pantryFormEle.insertBefore(searchContainerDiv, ingredientSearchEle.nextSibling);
        searchContainerDiv.parentElement.style.position = 'relative';
        searchContainerDiv.style.width = ingredientSearchEle.style.width;

      }
      searchContainerDiv.innerHTML = '';
      currentMatches.forEach(function(match, index) {
        div = document.createElement('div');
        div.innerText = match;
        // div.style.zIndex = 2;
        // div.style.position = 'absolute';
        div.style.backgroundColor = 'white';
        div.style.width = ingredientSearchEle.style.width;
        div.classList.add("ingredient_search_result")
        searchContainerDiv.append(div);

        // hover highliht
        searchContainerDiv.addEventListener('mouseover', function(e) {
            e.target.style.backgroundColor = 'lightgrey';
        });
        searchContainerDiv.addEventListener('mouseout', function(e) {
            e.target.style.backgroundColor = 'white';
        });

        // select element
        searchContainerDiv.addEventListener('click', function(e) {
          if (e.target !== searchContainerDiv) {
            ingredientSearchEle.value = e.target.innerText;
            searchContainerDiv.innerHTML = '';
          }
          var button = document.createElement('button')
          button.value = ''
        });

      });
      // console.log(e.key);
      // console.log(currentMatches);
    });

    pantry_form.addEventListener('click', function(e) {
      // Checks related checkbox when the label is clicked
      // console.log(e.target.type);
      if (e.target.type === 'checkbox') {

      }
      else {
        if (e.target.parentElement) {
          inputEle = e.target.parentElement.querySelector('input')
          if (inputEle) {
            inputEle.checked = !inputEle.checked
          }
        }
      }
    });

    window.addEventListener('click', function(e) {
        searchContainerDiv.innerHTML = '';
    });


  }

});

function search(searchString, ingredientArray) {
  matches = [];
  for (var i = 0; i < ingredientArray.length; i++) {
    if (ingredientArray[i].toLowerCase().includes(searchString.toLowerCase())) {
      matches.push(ingredientArray[i]);
    }
  }
  return matches
}

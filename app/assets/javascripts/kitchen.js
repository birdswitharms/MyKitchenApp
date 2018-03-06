var currentMatches = false;
document.addEventListener('DOMContentLoaded', function(e){

  var pantryFormEle = document.querySelector('#pantry_form') || document.querySelector('#recipe_form');
  var withinIngredientSearch = false;
  var searchContainerDiv = false;
  var addRemoveBtn = false;
  var searchContainerDiv = false;
  var pantrySubmitEle = document.querySelector('#pantry_submit_button');
  if (pantryFormEle) {
    // var IngredientArr = document.querySelector('#ingredient_list_').value.split(',')
    // console.(IngredientArr);
    // console.(document.querySelector('#ingredient1'));
    if (document.querySelector('#ingredient_list_')) {
      var ingredientList = document.querySelector('#ingredient_list_').value.split(',').sort()
    }
    else {
      var ingredientList = []
    }
    if (ingredientList && ingredientList.length === 0) {
      var ingredientsNodes = document.querySelectorAll("label");
    }

    var ingredientSearchEle = document.querySelector("#ingredient_search") || document.querySelector('#ingredient1');
    //
    ingredientSearchEle.style.width = '220px';
    if (pantrySubmitEle) {
      pantrySubmitEle.style.width = ingredientSearchEle.offsetWidth + 'px';
      pantrySubmitEle.style.height = (ingredientSearchEle.getBoundingClientRect().bottom - ingredientSearchEle.getBoundingClientRect().top) * 2  + 'px';
    }

    if (!searchContainerDiv) {
      searchContainerDiv = document.createElement('div');
      pantryFormEle.insertBefore(searchContainerDiv, ingredientSearchEle.nextSibling);
      searchContainerDiv.style.width = ingredientSearchEle.style.width;
      searchContainerDiv.parentElement.style.position = 'relative';
      searchContainerDiv.style.position = 'absolute';

      // console.log(ingredientSearchEle.getBoundingClientRect().bottom + 'px');
      searchContainerDiv.style.top = ingredientSearchEle.getBoundingClientRect().bottom -  pantryFormEle.getBoundingClientRect().top + 'px';
      searchContainerDiv.style.left = ingredientSearchEle.getBoundingClientRect().left - pantryFormEle.getBoundingClientRect().left + 'px';
      // pantryFormEle.getBoundingClientRect().top  + 'px';

    }
    // debug
    // console.log(ingredientsNodes);
    if (ingredientsNodes) {
      for (var i = 0; i < ingredientsNodes.length; i++) {
        ingredientList.push(ingredientsNodes[i].innerText);
      }
    }

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

      if (addRemoveBtn) {
        var temp_parent = addRemoveBtn.parentElement
        temp_parent.removeChild(addRemoveBtn);
        addRemoveBtn = null;
      }
        if (e.key === 'Backspace') {
          currentMatches = search(ingredientSearchEle.value.slice(0,-1), ingredientList)
        }
        else {
          currentMatches = search(ingredientSearchEle.value + e.key, ingredientList)
        }

      searchContainerDiv.innerHTML = '';

      if (currentMatches) {
        currentMatches.forEach(function(match, index) {
          div = document.createElement('div');
          div.innerText = match;
          // div.style.zIndex = 2;
          // div.style.position = 'absolute';
          div.style.backgroundColor = 'white';
          div.style.width = ingredientSearchEle.style.width;
          div.classList.add("ingredient_search_result")
          searchContainerDiv.append(div);
          // console.log(searchContainerDiv);

        });
      }

        // hover highliht
        searchContainerDiv.addEventListener('mouseover', function(e) {
            e.target.style.backgroundColor = 'lightgrey';
        });
        searchContainerDiv.addEventListener('mouseout', function(e) {
            e.target.style.backgroundColor = 'white';
        });

      }


      });

      // select element
      searchContainerDiv.addEventListener('click', function(e) {
        if (e.target !== searchContainerDiv) {
          ingredientSearchEle.value = e.target.innerText;
          searchContainerDiv.innerHTML = '';
          // add button to add or remove
          if (ingredientsNodes) {
            for (var i = 0; i < ingredientsNodes.length; i++) {
              if (ingredientsNodes[i].innerText.toLowerCase() === ingredientSearchEle.value.toLowerCase()) {
                addRemoveBtn = document.createElement('button')
                addRemoveBtn.style.position = 'absolute';
                addRemoveBtn.style.width = '20%';
                addRemoveBtn.style.height = ingredientSearchEle.style.height;
                addRemoveBtn.style.left = parseInt(ingredientSearchEle.style.width) + 6 + 'px';
                addRemoveBtn.style.top = ingredientSearchEle.getBoundingClientRect().top - pantryFormEle.getBoundingClientRect().top  + 'px';
                var currentCheckbox = ingredientsNodes[i].parentElement.querySelector('input')
                if (currentCheckbox.checked === true) {
                  addRemoveBtn.innerText = 'Remove';
                  addRemoveBtn.style.backgroundColor = 'lightcoral';
                }
                else {
                  addRemoveBtn.innerText = 'Add';
                  addRemoveBtn.style.backgroundColor = 'lightgreen';
                }
              }
            }

            pantryFormEle.append(addRemoveBtn)
            addRemoveBtn.addEventListener('click', function(e) {
              e.preventDefault();
              pantrySubmitEle.style.backgroundColor = 'khaki';
              pantrySubmitEle.style.fontWeight = 'bold';
              if (addRemoveBtn.innerText === 'Add') {
                for (var i = 0; i < ingredientsNodes.length; i++) {
                  if (ingredientsNodes[i].innerText.toLowerCase() === ingredientSearchEle.value.toLowerCase()) {
                    ingredientsNodes[i].parentElement.querySelector('input').checked = true;
                  }
                }
              }
              else {
                for (var i = 0; i < ingredientsNodes.length; i++) {
                  if (ingredientsNodes[i].innerText.toLowerCase() === ingredientSearchEle.value.toLowerCase()) {
                    ingredientsNodes[i].parentElement.querySelector('input').checked = false;
                  }
                }
              }
              var temp_parent = addRemoveBtn.parentElement
              temp_parent.removeChild(addRemoveBtn);
              addRemoveBtn = null;

            });
          }



        }
        var button = document.createElement('button')
        button.value = ''
      });

    pantryFormEle.addEventListener('click', function(e) {
      // Checks related checkbox when the label is clicked
      console.log(e.target.nodeName);
      if (e.target !== ingredientSearchEle && (e.target.nodeName === 'LABEL' || e.target.nodeName === 'INPUT')) {
        pantrySubmitEle.style.backgroundColor = 'khaki';
        pantrySubmitEle.style.fontWeight = 'bold';

        if (e.target.parentElement) {
          inputEle = e.target.parentElement.querySelector('input')
          if (inputEle && e.target.nodeName !== 'INPUT') {
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
  // console.log(matches);
  return matches
}

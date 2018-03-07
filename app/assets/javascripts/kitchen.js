var currentMatches = false;
var searchContainerDiv = false;

document.addEventListener('DOMContentLoaded', function(e) {

searcher(document);

});  // this function below suppose to be outside of DOMContentLoaded?

function searcher(document) {
    var pantryFormEle = document.querySelector('#pantry_form') || document.querySelector('#recipe_form');
    var withinIngredientSearch = false;
    var addRemoveBtn = false;
    var pantrySubmitEle = document.querySelector('#pantry_submit_button');
    if (pantryFormEle) {
      if (document.querySelector('#ingredient_list_')) {
        var ingredientList = document.querySelector('#ingredient_list_').value.split('~').sort()
      }
      else {
        var ingredientList = []
      }
      if (ingredientList && ingredientList.length === 0) {
        var ingredientsNodes = document.querySelectorAll("label");
      }

      ingredientSearchEle = document.querySelector("#ingredient_search") || document.querySelector('.ingredient_search_input');
      if (pantrySubmitEle) {
        pantrySubmitEle.style.width = ingredientSearchEle.offsetWidth + 'px';
        pantrySubmitEle.style.height = (ingredientSearchEle.getBoundingClientRect().bottom - ingredientSearchEle.getBoundingClientRect().top) * 2  + 'px';
      }
      if (!searchContainerDiv) {

        var searchContainerDiv = document.createElement('div');
        pantryFormEle.append(searchContainerDiv)
        searchContainerDiv.style.width = ingredientSearchEle.style.width;
        searchContainerDiv.parentElement.style.position = 'relative';
        searchContainerDiv.style.position = 'absolute';
        searchContainerDiv.id = 'searchDiv';

        searchContainerDiv.style.top = ingredientSearchEle.getBoundingClientRect().bottom -  pantryFormEle.getBoundingClientRect().top + 'px';
        searchContainerDiv.style.left = ingredientSearchEle.getBoundingClientRect().left - pantryFormEle.getBoundingClientRect().left + 'px';

      }
      else {
      }
      if (ingredientsNodes) {
        for (var i = 0; i < ingredientsNodes.length; i++) {
          ingredientList.push(ingredientsNodes[i].innerText);
        }
      }

      // check first if search is focused

      ingredientSearchEle.addEventListener('blur', addBlur);
      ingredientSearchEle.addEventListener('focus', addFocus);

      // every key press runs new search
      window.addEventListener('keydown', function(e){
        console.log(`ran keydown on ${e.target.id}`);
        if (ingredientSearchEle === e.srcElement) {
          console.log("element is the same");
        if (addRemoveBtn) {
          var temp_parent = addRemoveBtn.parentElement
          temp_parent.removeChild(addRemoveBtn);
          addRemoveBtn = null;
        }
          if (e.key === 'Backspace') {
            var searchString = ingredientSearchEle.value.slice(0,-1)
            var currentMatches = search(searchString, ingredientList)
          }
          else {
            var searchString = ingredientSearchEle.value + e.key
            var currentMatches = search(searchString, ingredientList)
          }
          // console.dir(searchString);
          // console.dir(ingredientList);
          // console.dir(ingredientSearchEle)
          console.dir(matches);
        searchContainerDiv.innerHTML = '';

        if (currentMatches) {
          currentMatches.forEach(function(match, index) {
            var div = document.createElement('div');
            var regex = new RegExp(searchString, 'gi');
            div.innerHTML = match.replace(regex, `<span class="hl">${searchString}</span>`);
            div.style.backgroundColor = 'white';
            div.style.width = ingredientSearchEle.offsetWidth + 'px';
            div.classList.add("ingredient_search_result")
            searchContainerDiv.append(div);
            console.log(searchContainerDiv);

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
                  addRemoveBtn.style.width = '80px';
                  addRemoveBtn.style.height = ingredientSearchEle.style.height;
                  addRemoveBtn.style.left = ingredientSearchEle.getBoundingClientRect().right - pantryFormEle.getBoundingClientRect().left  + 'px'
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
        if (pantrySubmitEle && e.target !== ingredientSearchEle && (e.target.nodeName === 'LABEL' || e.target.nodeName === 'INPUT')) {
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

    const checkboxes = document.querySelectorAll('.pantry [type="checkbox"]');

    let lastChecked;

    function handleCheck(e) {
      // check if they had the shift key down
      let inBetween = false;
      if (e.shiftKey && this.checked) {
        checkboxes.forEach(checkbox => {
          if (checkbox === this || checkbox === lastChecked) {
            inBetween = !inBetween;
            console.log('Starting to check them inbetween!');
          }

          if (inBetween) {
            checkbox.checked = true;
          }
        });
      };

      lastChecked = this;
    };

    checkboxes.forEach(checkbox => checkbox.addEventListener('click', handleCheck));

}


function search(searchString, ingredientArray) {
  matches = [];
  for (var i = 0; i < ingredientArray.length; i++) {
    if (ingredientArray[i].toLowerCase().includes(searchString.toLowerCase())) {
      matches.push(ingredientArray[i]);
    }
  }
  return matches
}

function addBlur(e) {
    withinIngredientSearch = false;
    ingredientSearchEle = e.target
}

function addFocus(e) {
  var pantryFormEle = document.querySelector('#pantry_form') || document.querySelector('#recipe_form');
    console.log(`ran focus on ${e.target.id}`);
    withinIngredientSearch = true;
    ingredientSearchEle = e.target
    searchContainerDiv = document.querySelector('#searchDiv');
    searchContainerDiv.style.top = ingredientSearchEle.getBoundingClientRect().bottom -  pantryFormEle.getBoundingClientRect().top + 'px';
    searchContainerDiv.style.left = ingredientSearchEle.getBoundingClientRect().left - pantryFormEle.getBoundingClientRect().left + 'px';
}

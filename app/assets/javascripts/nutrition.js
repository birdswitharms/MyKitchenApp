const dailyPotassiumInMg = 4700.0;

document.addEventListener('DOMContentLoaded', function(e){

  nutritionDiv = document.querySelector('.nutrition')

  if (nutritionDiv) {
    nutritionDiv.style.backgroundColor = 'GhostWhite';
    potassiumPercent = parseFloat(document.querySelector('#nutrition_potassium').innerText) / dailyPotassiumInMg * 100
    $(nutritionDiv).nutritionLabel({
      'showServingUnitQuantity' : false,
      // 'itemName' : 'Bleu Cheese Dressing',
      // 'ingredientList' : 'Bleu Cheese Dressing',

      'decimalPlacesForQuantityTextbox' : 2,
      'valueServingUnitQuantity' : 2,
      'showServingUnitQuantity' : true,
      'hideTextboxArrows' : false,


      'allowFDARounding' : true,
      'decimalPlacesForNutrition' : 2,

      'showPolyFat'       : false,
      'showMonoFat'       : false,
      'showTransFat'      : false,
      'showFatCalories'   : false,
      'showItemName'      : false,
      'showVitaminD'      : false,
      'showPotassium_2018': true,
      'showCalcium'       : false,
      'showIron'          : false,
      'showAddedSugars'   : false,

      'valueCalories'      : document.querySelector('#nutrition_calories').innerText,
      'valueTotalFat'      : document.querySelector('#nutrition_total_fat').innerText,
      'valueSatFat'        : document.querySelector('#nutrition_saturated_fat').innerText,
      'valueCholesterol'   : document.querySelector('#nutrition_cholesterol').innerText,
      'valueSodium'        : document.querySelector('#nutrition_sodium').innerText,
      'valueTotalCarb'     : document.querySelector('#nutrition_total_carbohydrates').innerText,
      'valueFibers'        : document.querySelector('#nutrition_dietary_fiber').innerText,
      'valueSugars'        : document.querySelector('#nutrition_sugars').innerText,
      'valueProteins'      : document.querySelector('#nutrition_protein').innerText,
      'valuePotassium_2018'     : potassiumPercent,
      'showLegacyVersion'  : false
    });
  }

});

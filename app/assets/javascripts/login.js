document.addEventListener('DOMContentLoaded', function(e){

  // loginEle = document.querySelector("a[href='/sessions/new']");
  var loginEle = document.querySelector("#loginlink");
  var modaldivEle = document.querySelector(".modal");
  // console.log(loginEle);
  if (loginEle) {
    loginEle.addEventListener('click', function(event) {
      event.preventDefault();
      hamburger.click();
      $.ajax({
        url: '/sessions/new',
        method: 'GET'
      }).done(function(responseData) {
        // console.log(responseData);
        modaldivEle.innerHTML = responseData
        modaldivEle.classList.toggle("modal");
        modaldivEle.classList.toggle("modalattr");

        // console.log(responseData);
        // var responseEle = document.createElement('p').innerHTML = responseData.body;''
        // responseData.querySelector
        // modaldivEle.append(responseEle);

      }).fail(function(_jqXHR, textStatus, errorThrown) {

      });
    });
  }
});

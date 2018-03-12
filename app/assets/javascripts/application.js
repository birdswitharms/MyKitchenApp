// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require jquery-ui
//= require_tree .

document.addEventListener('DOMContentLoaded', function(e){
  const topMenuLinks = document.querySelectorAll('.menu > a');
  const highlight = document.createElement('span');
  highlight.classList.add('top_highlighted');
  highlight.style.display = 'none';
  // highlight.style.zIndex = 3;
  document.body.append(highlight);

  window.onresize = function() {
    highlight.style.display = 'none';
  }

  function highlightLink() {
      // console.log(this);
      const linkCoords = this.getBoundingClientRect();
      // console.log(linkCoords);
      const coords = {
        width: linkCoords.width,
        height: linkCoords.height,
        top: linkCoords.top + window.scrollY,
        left: linkCoords.left + window.scrollX
      }
      highlight.style.width = `${coords.width}px`;
      highlight.style.height = `${coords.height}px`;
      highlight.style.transform = `translate(${coords.left}px, ${coords.top}px)`;

      highlight.style.display = 'block';
      highlight.style.background = 'GhostWhite';
    }
  topMenuLinks.forEach(a => a.addEventListener('mouseenter', highlightLink));
});

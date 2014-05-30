$(function() {
  var body = $('#welcomeBackground');
  var backgrounds = ['url(http://static.jsbin.com/images/jsbin_static.png)', 'url(http://static.jsbin.com/images/popout.png)'];
var current = 0;

function nextBackground() {
  body.css(
   'background',
    backgrounds[current = ++current % backgrounds.length]
 );

 setTimeout(nextBackground, 5000);
 }
 setTimeout(nextBackground, 5000);
   body.css('background', backgrounds[0]);
 });
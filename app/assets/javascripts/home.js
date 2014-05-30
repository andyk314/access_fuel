$(function() {
  var body = $('#welcomeBackground');
  var backgrounds = ['url(http://wallpic.us/wp-content/uploads/2014/04/LA-City-At-Night-Wallpaper.jpg)', 'url(http://mandarincommunicationsgroup.com/wp-content/uploads/2014/01/los-angeles.jpg)', 'url(http://mixhdwallpapers.com/wp-content/uploads/2014/03/311.jpg)'];
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
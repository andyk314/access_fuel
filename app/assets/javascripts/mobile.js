$(document).ready(function(){

	var swipeModule = (function() {

		var swipeModule = function () {
			var self = this;

			self.currentState = 0;
			self.speed = 500;

			self.init();
	  };

		swipeModule.prototype = {
			init: function(){
				var self = this;

				// Init touch swipe
				$(".event_wrapper").swipe({
					swipeStatus : swipeStatus,
					// triggerOnTouchEnd : true,
				  threshold: 1200,
          cancelThreshold:10
				});

				function swipeStatus(event, phase, direction, distance, fingers){
					console.log(phase);
					// target = $(this);
					//If we are moving before swipe, and we are going L or R, then manually drag the images
					if( phase=="move" && (direction=="left" || direction=="right") )
					{
						var duration=0;

						if (direction == "left") {
							console.log("left", distance);
							self.swipeAction($(this).prev(".red_overlay"), 0 - distance, duration);
						} else if (direction == "right") {
							console.log("right", distance);
							self.swipeAction($(this).next(".green_overlay"), distance, duration);
						}
							
					}

					//Else, cancel means snap back to the begining
					else if ( phase == "cancel")
					{

						// scrollImages(IMG_WIDTH * currentImg, speed);
						self.swipeAction($(this).prev(".red_overlay"), 0, 200);
						self.swipeAction($(this).next(".green_overlay"), $(this).next(".green_overlay").width(), 200);
					}

					//Else end means the swipe was completed, so move next
					else if ( phase =="end" )
					{
						if (direction == "right"){
							self.likeEvent($(this).next(".green_overlay"));
						} else if (direction == "left") {
							self.dislikeEvent($(this).prev(".red_overlay"));
						}
					}
				}

				// init events
				// this.swipeEvent();
			},
			swipeAction: function(target, distance, duration)
			{
				target.css("-webkit-transition-duration", (duration/1000).toFixed(1) + "s");

				//inverse the number we set in the css
				// var value = (distance<0 ? "" : "-") + Math.abs(distance).toString();

				target.css("-webkit-transform", "translate3d("+distance.toString() +"px,0px,0px)");
			},
			dislikeEvent: function(tmpTarget){
				var self = this,
						position = self.currentState,
						likeOrDislike;

		    self.swipeAction(tmpTarget, (0 - tmpTarget.width()), self.speed);

			},
			likeEvent: function(tmpTarget){
				var self = this;

				self.swipeAction(tmpTarget, tmpTarget.width(), self.speed);

			}

		};

		return swipeModule;

	})();

	var swiper = new swipeModule();

});
// ######## Set Cookie #############
function setCookie(id){
	if(document.cookie.indexOf(id)== -1){
		document.cookie = document.cookie + id + "-";
	}
	else{
		var subs = document.cookie;
		var news = subs.replace(id + "-", "");
		document.cookie = news;
	};
	// console.log("ID: " + id);
	// console.log("COOKIE: " + document.cookie);
};

// #########Test to see if any cookies exists############
function checkCookie(id){
	if(document.cookie.indexOf('id=')== -1){
		document.cookie = "id=";
}
	// addYellowClass();
	setCookie(id);
	
}




// ######## Add class yellow in index page if it's a favorite event
						
function  addYellowClass() {
	console.log("Start");
	var matches = []	
	var d = document.getElementsByClassName('glyphicon-star');
	
	for (var i=0; i<d.length; i++) {
		var start = String(d[i].onclick).lastIndexOf('e') + 2;
		var end = String(d[i].onclick).lastIndexOf(' ') + 1;
		var fav_id = parseInt(String(d[i].onclick).slice(start, end)) // Grabs id
		// console.log( fav_id );

		if (document.cookie.indexOf(fav_id)!= -1) {
			d[i].className += " yellow";
			matches.push(fav_id);
		// 	}d[1].className += " yellow";
		}
	} 	console.log("mat1" + matches);	
								
}						






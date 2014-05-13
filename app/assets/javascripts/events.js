// ######## Set Cookie #############
function setCookie(id){
	if(document.cookie.indexOf(id)== -1){
		document.cookie = "id" + id + "=" + id + "; "
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
		// console.log("checkCookie");
		// document.cookie = "id=-";
}
	setCookie(id);
	
}




// // ######## Add class yellow in index page if it's a favorite event
						
// function  addYellowClass() {
// 	console.log("Start");
// 	var matches = []	
// 	var d = document.getElementsByClassName('glyphicon-star');
	
// 	for (var i=0; i<d.length; i++) {
// 		var start = String(d[i].onclick).lastIndexOf('e') + 2;
// 		var end = String(d[i].onclick).lastIndexOf(' ');
// 		var fav_id = parseInt(String(d[i].onclick).slice(start, end)); // Grabs id

// 		if (document.cookie.indexOf('-' + fav_id + '-')!= -1) {		
// 			d[i].className += " yellow";
// 			matches.push(fav_id);
// 		}
// 	} 	console.log("cookies:" + matches);	
								
// }						





// // ######## Set Cookie #############
// function setCookie(cname, cvalue){
// 	console.log("Set the cookie " + cvalue);
// 	document.cookie = cname + cvalue + "=" + cvalue + "; ";
// }

// // ######## Get Cookie #############
// function getCookie(cname, cvalue) {
// 	console.log("Grab the cookie: " + cvalue);
// 	var name = cname + "=";
// 	console.log("Grab cookie: " + name);
// 	var ca = document.cookie.split(';');
// 	console.log("ca: " + ca);
// 	for(var i=0; i<ca.length; i++) {
// 		var c = ca[i].trim();
// 		if(c.indexOf(name)=0) {
// 			return c.substring(name.length, c.length);
// 		} return "";
// 	}
// }

// // ######### Check for a Cookie ############
// function checkCookie(cvalue) {
// 	console.log("checking cookies: " + cvalue);
// 	var id = getCookie(("id" + cvalue),cvalue);
// 	if( id !="") {
// 		console.log('getting cookie: ' + id);
// 	}
// 	else {
// 		setCookie('id', cvalue);
// 		console.log('setting cookie: ' + cvalue);
// 	}
// }



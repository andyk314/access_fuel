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
	console.log("COOKIE Added: " + id);
};

// ###### Delete Cookie ###########
function deleteCookie(id) {
	// var now = new Date();
	var id_to_be_deleted = "id" + id + "=" + "; " + "expires=Thu, 01 Jan 1970 00:00:00 GMT"
	console.log("COOKIE Deleted: " + id_to_be_deleted);
	document.cookie = id_to_be_deleted;
}


// ######### Test to see if any cookies exists ############
function checkCookie(id){
	if(document.cookie.indexOf('id' + id)== -1){	
		console.log("COOKIE: " + document.cookie);
		setCookie(id);
	}
	else {
		deleteCookie(id);
	}
	
}


// ######## Add class yellow in index page if it's a favorite event
function  addYellowClass() {
	var matches = []	
	var d = document.getElementsByClassName('glyphicon-star');
	
	for (var i=0; i<d.length; i++) {
		var start = String(d[i].onclick).lastIndexOf('e') + 2;
		var end = String(d[i].onclick).lastIndexOf(' ');
		var fav_id = parseInt(String(d[i].onclick).slice(start, end));

		if (document.cookie.indexOf('id' + fav_id)!= -1) {		
			d[i].className += " yellow";
			matches.push(fav_id);
		}
	}							
}						





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



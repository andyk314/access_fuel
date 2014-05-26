// ######## Set Cookie #############
function setCookie(id){
	document.cookie = "id" + id + "=" + id + "; "
	console.log("COOKIE Added: " + id);
};

// ###### Delete Cookie ###########
function deleteCookie(id) {
	// if(document.cookie.indexOf("id" + id + "=") == 0){
	// 	document.cookie 
	// 	console.log("delete all")
	// }
	// else {
		var id_to_be_deleted = "id" + id + "=; expires=Thu, 01 Jan 2014 00:00:00 GMT"
		console.log("COOKIE Deleted: " + id_to_be_deleted);
		document.cookie = id_to_be_deleted;
		console.log(document.cookie);
	// }
}

// ######### Test to see if any cookies exists ############
function checkCookie(id){
	if(document.cookie.indexOf('id' + id)== -1){	
		console.log("COOKIES: " + document.cookie);
		setCookie(id);
	}
	else {
		deleteCookie(id);
	}
	
}

// ######## Add class yellow in index page if it's a favorite event
function  addYellowClass() {
	console.log('Add Yellow Class');
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

function favorite() {
	console.log('Favorite function');
	$(".glyphicon-star index").click(function(){
		$(this).toggleClass('yellow');
		console.log("Testing");
	});
}






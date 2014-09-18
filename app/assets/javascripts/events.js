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

// ######## Refactoring Code from Star Icon to Enable User to Favorite Event by Swiping Right


function favorite() {
	console.log('Favorite function');
	$(".glyphicon-star-empty index").click(function(){
		$(this).toggleClass('yellow');
		console.log("Testing");
	});
}
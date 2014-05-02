

	function setCookie(id){
		console.log(id);
		if(document.cookie.indexOf(id)== -1){
			document.cookie = document.cookie + id + "-";
		}
		else{
			// var x= document.cookie.indexOf(id);
			var subs = document.cookie;
			var news = subs.replace(id + "-", "");
			document.cookie = news;
		};
		console.log(document.cookie);
	}


	function checkCookie(id){
		if(document.cookie.indexOf('id=')== -1){
			document.cookie = "id=";
		}
		console.log('tests');
		setCookie(id);
	}




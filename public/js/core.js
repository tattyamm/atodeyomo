(function() {
	console.log("js!");

	var formeObj = document.createElement('form');
	var urlObj = document.createElement('input');
	var titleObj = document.createElement('input');
	urlObj.name = "url";
	urlObj.value = location.href;
	titleObj.name = "webdatum";
	titleObj.value = document.title;

	// form
	formeObj.appendChild(urlObj);
	formeObj.appendChild(titleObj);
	formeObj.style.display = 'none';
	try{
		document.body.appendChild(formeObj);
	}catch(e){
		document.appendChild(formeObj);
	}

	// submit
	var chr = document.charset;
	formeObj.action = "https://atodeyomo.herokuapp.com/api/webdata";
	formeObj.method = "POST";
	formeObj.acceptCharset = "utf-8";
	document.charset = "utf-8";
	formeObj.submit();
	document.charset = chr;

})();

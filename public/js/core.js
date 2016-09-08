(function() {
	console.log("js!");

	var formeObj = document.createElement('form');
	var urlObj = document.createElement('input');
	var titleObj = document.createElement('input');
	var sourceObj = document.createElement('input');
	urlObj.name = "url";
	urlObj.value = location.href;
	titleObj.name = "title";
	titleObj.value = document.title;
	sourceObj.name = "webdatum";
	sourceObj.value = document.lastChild.innerHTML;

	// form
	formeObj.appendChild(urlObj);
	formeObj.appendChild(titleObj);
	formeObj.appendChild(sourceObj);
	formeObj.style.display = 'none';
	try{
		document.body.appendChild(formeObj);
	}catch(e){
		document.appendChild(formeObj);
	}

	// submit
	var pageCharset = document.charset;
	//formeObj.action = "https://atodeyomo.herokuapp.com/api/webdata";
	formeObj.action = "http://localhost:3000/api/webdata";
	formeObj.method = "POST";
	formeObj.acceptCharset = "utf-8";
	document.charset = "utf-8";
	formeObj.submit();
	document.charset = pageCharset;

})();

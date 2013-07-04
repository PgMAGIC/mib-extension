var port = chrome.runtime.connect({'name' : 'websocket-stuff'});
port.onMessage.addListener(function(msg){

})

$(document).on("mousedown touchstart", "textarea, input[type=text]", function(e){
	//Show qr code
	var x = e.pageX;
	var y = e.pageY;

	$qrCodeElem = $('#qrcode-icon-ext');

	if($qrCodeElem.length > 0){
		$qrCodeElem.show();
	} else {
		var newdiv = document.createElement('div'); 
		newdiv.setAttribute('id','qrcode-icon-ext');
		document.body.appendChild(newdiv)
		$qrCodeElem = $('#qrcode-icon-ext');
	}

	$qrCodeElem.css("position", "absolute");
	$qrCodeElem.css("top", y);
	$qrCodeElem.css("left", x);
	$qrCodeElem.css("width", "100px");
	$qrCodeElem.css("height", "100px");
	// $qrCodeElem.css("background-color", "red");
	$qrCodeElem.css("z-index", 100000);

	//TODO: generate ID on server
	$.get("http://localhost:8081/client-register").then(function(response){
		var address = "http://localhost:8081/qrcode/" + response;
		$qrCodeElem.html('<img src="' + address +'">');

		var channelname = "/mobileinput" + response;
		port.postMessage({"channelname" : channelname});

		port.onMessage.addListener(function(msg){
			$(e.target).val(msg.inputtext);
		})
	})
});

$(document).on("mouseup touchend", "textarea, input[type=text], #qrcode-icon-ext", function(e){
	$('#qrcode-icon-ext').hide();
});

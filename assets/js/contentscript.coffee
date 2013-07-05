port = chrome.runtime.connect({'name' : 'websocket-stuff'})
activationEvents = "mousedown touchstart"
disablingEvents = "mouseup touchend"



$(document).on(activationEvents, "textarea, input[type=text]", (e) -> 
	x = e.pageX;
	y = e.pageY;

	$qrCodeElem = $('#qrcode-icon-ext');

	if $qrCodeElem.length > 0
		$qrCodeElem.show()
	else 
		newdiv = document.createElement('div') 
		newdiv.setAttribute('id','qrcode-icon-ext')
		document.body.appendChild(newdiv)
		$qrCodeElem = $('#qrcode-icon-ext')
	
	$qrCodeElem.css("top", y)
	$qrCodeElem.css("left", x)

	$.get("http://localhost:8081/client-register").then (response) ->
		address = "http://localhost:8081/qrcode/#{response}"
		$qrCodeElem.html("<img src='#{address}'>")

		channelname = "/mobileinput#{response}"
		port.postMessage({"channelname" : channelname})

		port.onMessage.addListener((msg) ->
			$(e.target).val(msg.inputtext)
		)
	
)

$(document).on(disablingEvents, "textarea, input[type=text], #qrcode-icon-ext", (e) ->
	$('#qrcode-icon-ext').hide()
)

chrome.runtime.onConnect.addListener(function(port){
	port.onMessage.addListener(function(msg){
		var channelname = msg.channelname;
		console.log("connect: " + channelname);
		var socket = io.connect("http://localhost:8081" + channelname);
		socket.on("input:set", function(value){
			port.postMessage({"inputtext": value});
			console.log(value);
		});
	})
})
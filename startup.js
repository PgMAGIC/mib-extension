var serverAddress = localStorage["server_address"] || "localhost";
var serverPort = localStorage["server_port"] || 8081;

chrome.runtime.onConnect.addListener(function(port){
	port.onMessage.addListener(function(msg){
		var channelname = msg.channelname;
		var socket = io.connect("http://" + serverAddress +":" + serverPort +"" + channelname);
		socket.on("input:set", function(value){
			port.postMessage({"inputtext": value});
		});
	})
})
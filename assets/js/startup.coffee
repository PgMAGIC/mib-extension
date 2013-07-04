serverAddress = localStorage["server_address"] or "localhost"
serverPort = localStorage["server_port"] or 8081
chrome.runtime.onConnect.addListener (port) ->
  port.onMessage.addListener (msg) ->
    channelname = msg.channelname
    socket = io.connect("http://" + serverAddress + ":" + serverPort + "" + channelname)
    socket.on "input:set", (value) ->
      port.postMessage inputtext: value
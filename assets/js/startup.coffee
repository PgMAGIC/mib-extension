chrome.storage.sync.get "qr_server_options", (loaded)->
  serverAddress = loaded.qr_server_options.address
  serverPort = loaded.qr_server_options.port

  console.log "test123"

  chrome.runtime.onConnect.addListener (port) ->
    port.onMessage.addListener (msg) ->
      console.log "Connected to server: " + serverAddress
      channelname = msg.channelname
      socket = io.connect("http://" + serverAddress + ":" + serverPort + "" + channelname)
      socket.on "input:set", (value) ->
        port.postMessage inputtext: value
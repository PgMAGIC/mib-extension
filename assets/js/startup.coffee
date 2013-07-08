chrome.storage.sync.get "qr_server_options", (loaded)->
  serverAddress = loaded.qr_server_options.address
  serverPort = loaded.qr_server_options.port

  chrome.runtime.onConnect.addListener (port) ->
    if port.name == 'websocket-stuff'
      port.onMessage.addListener (msg) ->
        
        channelname = msg.channelname
        console.log "Connected to channel: #{channelname}"
        socket = io.connect("http://" + serverAddress + ":" + serverPort + "" + channelname)
        socket.on "input:set", (value) ->
          port.postMessage {
            inputtext: value
            channelname: channelname
          }


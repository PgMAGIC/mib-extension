serverAddress = false
serverPort = false

chrome.storage.sync.get "qr_server_options", (loaded)->
  serverAddress = loaded.qr_server_options.address
  serverPort = loaded.qr_server_options.port

  chrome.runtime.onConnect.addListener (port) ->
    if port.name == 'websocket-stuff'
      port.onMessage.addListener (msg) ->
        
        channelname = msg.channelname
        socket = io.connect("http://" + serverAddress + ":" + serverPort + "" + channelname)
        socket.on "input:set", (value) ->
          port.postMessage {
            inputtext: value
            channelname: channelname
          }

onOptionChange = (changes, namespace) ->
  newOptionValues = changes.qr_server_options.newValue
  serverAddress = newOptionValues.address
  serverPort = newOptionValues.port


chrome.storage.onChanged.addListener onOptionChange
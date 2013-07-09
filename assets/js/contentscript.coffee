port = chrome.runtime.connect({'name' : 'websocket-stuff'})
activationEvents = "mousedown touchstart"
disablingEvents = "mouseup touchend"

server = false
serverPort = false

init = (loaded)->
  server = loaded.qr_server_options.address
  serverPort = loaded.qr_server_options.port

  $(document).on(activationEvents, "textarea, input[type=text]", (e) -> 
    x = e.pageX;
    y = e.pageY;

    $qrCodeElem = $('#qrcode-icon-ext');

    if $qrCodeElem.length is 0
      newdiv = document.createElement('div') 
      newdiv.setAttribute('id','qrcode-icon-ext')
      document.body.appendChild(newdiv)
      $qrCodeElem = $('#qrcode-icon-ext')
    
    $qrCodeElem.css("top", y)
    $qrCodeElem.css("left", x)

    $.get("http://#{server}:#{serverPort}/client-register").then (response) ->
      address = "http://#{server}:#{serverPort}/qrcode/#{response}"
      $qrCodeElem.html("<img src='#{address}'>")
      $qrCodeElem.show()

      channelname = "/mobileinput#{response}"
      port.postMessage({"channelname" : channelname})

      inputCallback = (msg) ->
        if channelname == msg.channelname
          $(e.target).val(msg.inputtext)

      port.onMessage.addListener inputCallback
    
  )

  $(document).on(disablingEvents, "textarea, input[type=text], #qrcode-icon-ext", (e) ->
    $('#qrcode-icon-ext').hide()
  )

chrome.storage.sync.get "qr_server_options", init

onOptionChange = (changes, namespace) ->
  newOptionValues = changes.qr_server_options.newValue
  server = newOptionValues.address
  serverPort = newOptionValues.port


chrome.storage.onChanged.addListener onOptionChange
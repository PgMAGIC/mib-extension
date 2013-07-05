# Save this script as `options.js`

# Saves options to localStorage.
save_options = ->
  server_address = $ "#server-address".val()
  server_port = $ "server-port".val()

  chrome.storage.sync.set "qr_server_options" =
    "address" : server_address
    "port" : server_port
  , ->
    # Update status to let user know options were saved.
    status = $ "#status".html "Options Saved."
    setTimeout( ->
      $ "#status".html ""
    , 750)

# Restores select box state to saved value from localStorage.
restore_options = ->
  chrome.storage.sync.get "qr_server_options", (loaded) ->
    $ "#server-address".val loaded.qr_server_options.address
    $ "#server-port").val loaded.qr_server_options.port
    
$ -> restore_options
$ "#save".click save_options
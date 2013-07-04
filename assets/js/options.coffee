# Save this script as `options.js`

# Saves options to localStorage.
save_options = ->
  select = document.getElementById("server-address")
  server_address = select.value
  localStorage["server_address"] = server_address
  localStorage["server_port"] = document.getElementById("server-port").value
  
  # Update status to let user know options were saved.
  status = document.getElementById("status")
  status.innerHTML = "Options Saved."
  setTimeout( ->
    status.innerHTML = ""
  , 750)

# Restores select box state to saved value from localStorage.
restore_options = ->
  favorite = localStorage["server_address"]
  return  unless favorite
  select = document.getElementById("server-address")
  select.value = favorite
  document.getElementById("server-port").value = localStorage["server_port"]
document.addEventListener "DOMContentLoaded", restore_options
document.querySelector("#save").addEventListener "click", save_options
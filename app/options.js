// Save this script as `options.js`

// Saves options to localStorage.
function save_options() {
  var select = document.getElementById("server-address");
  var server_address = select.value;
  localStorage["server_address"] = server_address;
  localStorage["server_port"] = document.getElementById("server-port").value;

  // Update status to let user know options were saved.
  var status = document.getElementById("status");
  status.innerHTML = "Options Saved.";
  setTimeout(function() {
    status.innerHTML = "";
  }, 750);
}

// Restores select box state to saved value from localStorage.
function restore_options() {
  var favorite = localStorage["server_address"];
  if (!favorite) {
    return;
  }
  var select = document.getElementById("server-address");
  select.value = favorite;

  document.getElementById("server-port").value = localStorage["server_port"];

}
document.addEventListener('DOMContentLoaded', restore_options);
document.querySelector('#save').addEventListener('click', save_options);
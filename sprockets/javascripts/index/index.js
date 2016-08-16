//= require_tree .

document.addEventListener("DOMContentLoaded", function(event) {
    console.log('Ready');
    socket.onmessage = function (event) {
        console.log(event.data);
    };
});
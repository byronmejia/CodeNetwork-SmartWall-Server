/**
 * Created by byron on 17/08/16.
 */
var helloWorld = {
    "hello":"world"
};

const socketUri = "ws://" + location.host + "/ws";
var socket = new WebSocket(socketUri);

socket.onopen = function (event) {
    socket.send(
        JSON.stringify(helloWorld)
    );
};

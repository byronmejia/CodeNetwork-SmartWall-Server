/**
 * Created by byron on 17/08/16.
 */
var helloWorld = {
    "hello":"world"
};

const socketUri = "wss://" + location.host + "/ws";
var socket = new WebSocket(socketUri);

socket.onopen = function (event) {
    socket.send(
        JSON.stringify(helloWorld)
    );
};

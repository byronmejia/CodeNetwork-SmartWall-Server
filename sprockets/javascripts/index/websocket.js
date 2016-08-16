/**
 * Created by byron on 17/08/16.
 */
var helloWorld = {
    "hello":"world"
};

// Check if we are in development first...
var method;
if(location.host.startsWith('localhost') || location.host.startsWith('127.0.0.1')){
    method = 'ws://';
} else {
    method = 'wss://';
}

const socketUri = method + location.host + "/ws";
var socket = new WebSocket(socketUri);

socket.onopen = function (event) {
    socket.send(
        JSON.stringify(helloWorld)
    );
};

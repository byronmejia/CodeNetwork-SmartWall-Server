//= require components/domHelper
//= require_tree .

document.addEventListener("DOMContentLoaded", function(event) {
    var payload;
    var parentElement = gID('tweets');
    console.log('Document Content Loaded');

    socket.onmessage = function (event) {
        payload = JSON.parse(event.data);
        console.log(payload);
        // Start at top of Tree
        var childCard = document.createElement("div");
        childCard.className += 'card';
        var childChildContent = document.createElement("div");
        childChildContent.className += 'content';

        // Child Elements
        var childChildChildImage = document.createElement("img");
        childChildChildImage.className += 'right floated mini ui image';
        childChildChildImage.src += 'http://lorempixel.com/200/200';
        var childChildChildHeader = document.createElement("div");
        childChildChildHeader.className += 'header';
        childChildChildHeader.innerText += payload.name;
        var childChildChildDescription = document.createElement("div");
        childChildChildDescription.className += 'description';
        childChildChildDescription.innerText += payload.tweet;

        childChildContent.appendChild(childChildChildImage);
        childChildContent.appendChild(childChildChildHeader);
        childChildContent.appendChild(childChildChildDescription);

        childCard.appendChild(childChildContent);

        parentElement.appendChild(childCard);

        if(parentElement.childNodes.length > 10) {
            console.log("OVERLOADED");
            parentElement.removeChild(parentElement.childNodes[0]);
        }
    };
});
//= require components/domHelper
//= require_tree .

document.addEventListener("DOMContentLoaded", function(event) {
    var payload;
    var parentElement = gID('tweets');
    var questionElement = gID('questions');
    console.log('Document Content Loaded');

    socket.onmessage = function (event) {
        payload = JSON.parse(event.data);
        console.log(payload);
        if(payload.type === 'lengthy'){
            var card = getAnswerCard(payload);
            questionElement.insertBefore(card, questionElement.firstChild);

            if(parentElement.childNodes.length > 10) {
                console.log("Warning: Overloaded Questions");
                questionElement.removeChild(questionElement.lastChild);
            }
        } else {
            var card = genTweetCard(payload);
            parentElement.insertBefore(card, parentElement.firstChild);

            if(parentElement.childNodes.length > 10) {
                console.log("Warning: Overloaded");
                parentElement.removeChild(parentElement.lastChild);
            }
        }
    };

    setInterval(function(){
        socket.send(PING)
    }, 3000)
});
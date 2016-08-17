/**
 * Created by byron on 17/08/2016.
 */

function genTweetCard(payload){
    // First, check of weird AND symbol
    payload.tweet = payload.tweet.replace(/&amp;/g, '&');
    // Start at top of Tree
    var card = document.createElement("div");
    card.className += 'ui fluid card';
    var content = document.createElement("div");
    content.className += 'content';

    // Child Elements
    var childImage = document.createElement("img");
    childImage.className += 'right floated mini ui image';
    childImage.src += payload.profile_image;
    
    var childHeader = document.createElement("div");
    childHeader.className += 'header';
    childHeader.innerText += payload.name;
    
    var childMeta = document.createElement("div");
    childMeta.className += 'meta';
    childMeta.innerText += '@' + payload.username;
    
    var childDescription = document.createElement("div");
    childDescription.className += 'description';
    childDescription.innerText += payload.tweet;
    
    content.appendChild(childImage);
    content.appendChild(childHeader);
    content.appendChild(childMeta);
    content.appendChild(childDescription);
    card.appendChild(content);

    return card;
}

function getAnswerCard(payload){
    // First, check of weird AND symbol
    payload.response = payload.response.replace(/&amp;/g, '&');
    // Start at top of Tree
    var card = document.createElement("div");
    card.className += 'ui fluid card';
    var content = document.createElement("div");
    content.className += 'content';

    var childHeader = document.createElement("div");
    childHeader.className += 'header';
    childHeader.innerText += 'SmartWall Solution';

    var childDescription = document.createElement("div");
    childDescription.className += 'description';
    childDescription.innerText += payload.response;

    content.appendChild(childHeader);
    content.appendChild(childDescription);
    card.appendChild(content);

    return card;
}
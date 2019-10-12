const fs = require('fs');
const PRIVATE_KEY_LENGTH = 32;
/*
Generate secret
 */
var crypto = require("crypto");
var secret = crypto.randomBytes(PRIVATE_KEY_LENGTH / 2).toString('hex');

fs.writeFile("./server_secret.json", JSON.stringify({"secret": secret}), function (err) {
    if (err) {
        return console.log(err);
    }
    console.log("The secret file was saved!");
});
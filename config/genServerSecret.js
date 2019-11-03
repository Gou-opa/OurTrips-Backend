const fs = require('fs');
const PRIVATE_KEY_LENGTH = 32;
const sessionDB = require('../core/mysql/session');

/*
Generate secret
 */
var crypto = require("crypto");
var secret = crypto.randomBytes(PRIVATE_KEY_LENGTH / 2).toString('hex');
var prime_length = 60;
var diffHell = crypto.createDiffieHellman(prime_length);

diffHell.generateKeys('base64');
fs.writeFile("./server_secret.json",
    JSON.stringify({
        "secret": {
            "hex": {
                "secret": secret,
                "rsa": {
                    "public": diffHell.getPublicKey('hex'),
                    "private": diffHell.getPrivateKey('hex')
                }
            },
            "base64": {
                "rsa": {
                    "public": diffHell.getPublicKey('base64'),
                    "private": diffHell.getPrivateKey('base64')
                }
            }
        },
    }),
    function (err) {
        if (err) {
            return console.log(err);
        }
    }
);
console.log("The secret file was saved!");
sessionDB.expireAll(function (result) {
    console.log(result);

});

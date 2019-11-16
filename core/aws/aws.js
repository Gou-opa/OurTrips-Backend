const AWS = require('aws-sdk');
const config = require('./config');

AWS.config.accessKeyId = config.accessKeyId;
AWS.config.secretAccessKey = config.secretAccessKey;
AWS.config.region = config.region;

module.exports = AWS;
/**
 * Config
 */
const config = require('./../config/config').aws;
module.exports = {
    "cognito": config.cognito
};
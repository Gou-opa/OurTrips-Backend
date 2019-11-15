'use strict';
/**
 * lodash to merge json
 */
const lodash = require('lodash');
/**
 * merge configurations from default with particular env
 */
const config = require('./config.json');

const fs = require('fs');
const secretFile = fs.readFileSync("../config/server_secret.json");
const secret = JSON.parse(secretFile).secret;

const defaultConfig = config.default;
const environment = process.env.NODE_ENV || 'development';
const environmentConfig = config[environment];
const finalConfig = lodash.merge(defaultConfig, environmentConfig);

// as a best practice
// all global variables should be referenced via global. syntax
// and their names should always begin with g
const serverConfig = lodash.merge(finalConfig, {"secret": secret});
module.exports = serverConfig;
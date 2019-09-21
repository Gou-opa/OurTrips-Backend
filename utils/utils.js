const lodash = require('lodash');
const log = require('./log');
const callback = require('./callback');
module.exports = lodash.merge(log, callback);
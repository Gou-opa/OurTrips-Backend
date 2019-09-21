const log = require('./log');

module.exports.callback = {};
module.exports.callback.onFailure = (err) => {
    log.identify(err);
};
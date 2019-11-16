const AWS = require('aws-sdk');
AWS.config.loadFromPath('ourtrips_aws_user_credentials.json');
module.exports = AWS;
var express = require('express');
var router = express.Router();
const Account = require('../core/business_flow/user/account');

router.get('/', function(req, res, next) {
    res.render('./index.ejs', {pageID: 7, 'script': ''});
});
module.exports = router;

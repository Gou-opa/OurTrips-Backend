var express = require('express');
var router = express.Router();
const Account = require('./../business_flow/user/account');

router.get('/', function(req, res, next) {
    res.render('./component/licence/licence.ejs');
});

router.get('/add-licence', function(req, res, next) {
    res.render('./component/licence/addLicence.ejs');
});

router.get('/licence/edit-licence', function(req, res, next) {
    res.render('./index.ejs', {pageID: 9, 'script': ''});
});

module.exports = router;

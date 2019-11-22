var express = require('express');
var router = express.Router();
const Account = require('../business_flow/user/account');
const Bank = require('../business_flow/user/ewallet');

router.get('/', function(req, res){
    res.render('./component/ewallet/ewallet.ejs');
});


router.post('/register', function (req, res) {
    Account.AuthenThen(Bank.registerNewWallet, req, res);
});
router.post('/withdraw', function (req, res) {
    Account.AuthenThen(Bank.withdraw, req, res);
});
router.post('/charge', function (req, res) {
    Account.AuthenThen(Bank.charge, req, res);
});
router.post('/link', function (req, res) {
    Account.AuthenThen(Bank.link, req, res);
});
router.post('/info', function (req, res) {
    Account.AuthenThen(Bank.get, req, res);
});
router.post('/fetch', function (req, res) {
    Account.AuthenThen(Bank.fetch, req, res);
});
module.exports = router;
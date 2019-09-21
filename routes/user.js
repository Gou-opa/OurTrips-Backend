var express = require('express');
var router = express.Router();

const account = require('./../user/account');

/* GET users listing. */
router.get('/', function (req, res, next) {
    res.send('hello an user');
});
router.post('/register', function (req, res, next) {
    var form = req.body;
    account.RegisterUser(form, req, res);
});
// router.post('/verify', function (req, res, next) {
//     var verify_form = req.body;
//     account.VerifyUser(verify_form, req, res);
// });
router.post('/login', function (req, res, next) {
    var login_form = req.body;
    account.LoginUser(login_form, req, res);
});
router.post('/confirm', function (req, res, next) {
    var confirm_form = req.body;
    account.ConfirmUser(confirm_form, req, res);
});

module.exports = router;

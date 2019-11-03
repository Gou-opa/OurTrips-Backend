var express = require('express');
var router = express.Router();
const account = require('../business_flow/user/account');

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
router.post('/login', function (req, res) {
    var login_form = req.body;
    account.LoginUser(login_form, req, res);
});
router.post('/confirm', function (req, res) {
    var confirm_form = req.body;
    account.ConfirmUser(confirm_form, req, res);
});
router.post('/authen', function (req, res) {
    var authen_form = req.body;
    account.Verify(authen_form, req, res);
});
router.post('/logout', function (req, res) {
    var logout_form = req.body;
    account.LogOut(logout_form, req, res);
});
module.exports = router;

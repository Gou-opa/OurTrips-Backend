var express = require('express');
var router = express.Router();
const Account = require('../core/business_flow/user/account');
const Trip = require('../core/business_flow/map/trip');

router.post('/register', function (req, res, next) {
    var form = req.body;
    Account.RegisterUser(form, req, res);
});
// router.post('/verify', function (req, res, next) {
//     var verify_form = req.body;
//     Account.VerifyUser(verify_form, req, res);
// });
router.post('/login', function (req, res) {
    var login_form = req.body;
    Account.LoginUser(login_form, req, res);
});

router.post('/confirm', function (req, res) {
    var confirm_form = req.body;
    Account.ConfirmUser(confirm_form, req, res);
});
router.post('/logout', function (req, res) {
    Account.AuthenThen(Account.LogOut, req, res);
});
router.put('/location', function (req, res) {
    Account.AuthenThen(Account.SetLocation, req, res);
});
router.post('/pay', function (req, res) {
    Account.AuthenThen(Trip.pay, req, res);
});
/* legacy part */
router.post('/check_role', function (req, res) {
    Account.AuthenThen(Account.Verify, req, res);
});

router.get('/verification', function(req, res) {
    let username = req.query.username;
    let password = req.query.password;
    console.log(username, password);
    res.render('index', {pageID: 10, 'script': ''});
});

module.exports = router;

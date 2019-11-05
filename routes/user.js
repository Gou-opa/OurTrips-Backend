var express = require('express');
var router = express.Router();
const Account = require('../business_flow/user/account');

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
/* legacy part */
router.post('/check_role', function (req, res) {
    Account.AuthenThen(Account.Verify, req, res);
});


module.exports = router;

var express = require('express');
var router = express.Router();


router.get('/ping', function(req, res, next) {
	res.render('./login/app.ejs', { pageID: 1});
});

router.get('/register', function(req, res, next) {
	res.render('./login/app.ejs', { pageID: 2});
})

router.get('/forgot-password', function(req, res, next) {
	res.render('./login/app.ejs', { pageID: 0});
})


module.exports = router;

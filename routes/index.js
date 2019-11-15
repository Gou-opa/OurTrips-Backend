var express = require('express');
var router = express.Router();
const data = require('./data/city.json');

// phần đăng nhập
router.get('/', function(req, res, next) {
	res.render('./login/app.ejs', { pageID: 1, name: "Đăng nhập"});
});

router.get('/register', function(req, res, next) {
	res.render('./login/app.ejs', { pageID: 2, name: "Đăng ký"});
});

router.get('/forgot-password', function(req, res, next) {
	res.render('./login/app.ejs', { pageID: 0, name: "Quên mật khẩu"});
});

// hết phần đăng nhập

router.get('/home', function(req, res, next) {
	res.render('./index.ejs', {pageID: 1, 'script': ''});
});

router.get('/vehicle', function(req, res, next) {
	res.render('./index.ejs', { pageID: 2, 'script': ''});
});


router.get('/vehicle/add-vehicle', function(req, res, next) {
	res.render('./index.ejs', { pageID: 3, 'script': ''});
});

router.get('/vehicle/edit-vehicle', function(req, res, next) {
	res.render('./index.ejs', { pageID: 4, 'script': ''});
});

router.get('/driver', function (req, res, next) {
    res.render('./index.ejs', { pageID: 5, 'script': ''});
});

router.get('/driver/add-driver', function (req, res, next) {
    res.render('./index.ejs', { pageID: 6, 'data': data, 'script': '/custom/dropdownlist.js'});
});

router.get('/licence', function(req, res, next) {
	res.render('./index.ejs', {pageID: 7, 'script': ''});
});

router.get('/licence/add-licence', function(req, res, next) {
	res.render('./index.ejs', {pageID: 8, 'script': ''});
});

router.get('/licence/edit-licence', function(req, res, next) {
	res.render('./index.ejs', {pageID: 9, 'script': ''});
});







//xử lý ajax dropdown list, không động vô
router.get('/driver/tinh/:id', function(req, res) {
	res.sendFile(__dirname + '/data/district/'+req.params.id+".json");
});


module.exports = router;

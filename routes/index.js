var express = require('express');
var router = express.Router();

router.all('/ping', function (req, res) {
   res.json({"OurTrips" : "PONG"});
});
module.exports = router;

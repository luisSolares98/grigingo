var express = require('express');
var controller = require('../controllers/NivelController');

var router = express.Router();
router.get('/nivelByUser', controller.selectByUser);

module.exports = router;
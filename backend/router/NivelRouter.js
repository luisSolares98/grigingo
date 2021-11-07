var express = require('express');
var controller = require('../controllers/NivelController');

var router = express.Router();
router.get('/nivel', controller.selectAll);

module.exports = router;
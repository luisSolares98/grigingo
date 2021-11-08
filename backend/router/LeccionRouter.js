var express = require('express');
var controller = require('../controllers/LeccionesController');

var router = express.Router();
router.post('/lecciones_by_nivel', controller.selectByNivelId);
router.post('/lecciones_completed', controller.leccionCompleta);

module.exports = router;
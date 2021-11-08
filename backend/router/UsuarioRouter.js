var express = require('express');
var usuarioController = require('../controllers/UsuarioController');

var usuarioRouter = express.Router();
usuarioRouter.post('/usuario', usuarioController.insert);
usuarioRouter.post('/login', usuarioController.getLogin);
usuarioRouter.post('/usuario_update_experiencia', usuarioController.updateExperiencia);

module.exports = usuarioRouter;
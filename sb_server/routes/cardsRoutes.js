const express = require("express");
const cardController = require("../controllers/cardController");

const router = express.Router();

router.get("/", cardController.getCards);
router.get("/:id", cardController.getCardById);
//http://localhost:3000/api/casos/66e9c3caa65dfe5e11969a35
router.post("/crearCard", cardController.crearCard);

module.exports = router;

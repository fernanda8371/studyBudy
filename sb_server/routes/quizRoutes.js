const express = require("express");
const quizController = require("../controllers/quizesController");

const router = express.Router();

router.get("/", quizController.getQuizzes);
router.post("/crearQuiz", quizController.addQuiz);

module.exports = router;

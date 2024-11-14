const Quiz = require("../schemas/quizSchema"); // Import the Quiz model

// Get all quizzes
const getQuizzes = async (req, res) => {
  try {
    const quizes = await Quiz.find(); // Fetch all quizzes from the database
    res.status(200).json(quizes); // Respond with a 200 status and the quizzes
  } catch (err) {
    console.error("Error fetching quizzes:", err);
    res.status(500).json({ message: "Error fetching quizzes" }); // Internal server error if fetching fails
  }
};

// Add a new quiz
const addQuiz = async (req, res) => {
  const { name, text, answer } = req.body;

  if (!name || !text || !answer) {
    return res
      .status(400)
      .json({ message: "Name, text, and answer are required" }); // Bad request if missing fields
  }

  try {
    const newQuiz = new Quiz({
      name,
      text,
      answer,
    });

    await newQuiz.save(); // Save the new quiz to the database
    res.status(201).json(newQuiz); // Respond with a 201 status and the newly created quiz
  } catch (err) {
    console.error("Error saving new quiz:", err);
    res.status(500).json({ message: "Error saving new quiz" }); // Internal server error if saving fails
  }
};

module.exports = {
  getQuizzes,
  addQuiz,
};

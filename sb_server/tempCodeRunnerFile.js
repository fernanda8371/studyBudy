const express = require("express");
const cors = require("cors");

const dotenv = require("dotenv");
const connectDB = require("./config/db");

const chatGPTRoutes = require("./routes/chatGPTRoutes");
const cardsRoutes = require("./routes/cardsRoutes");
const quizRoutes = require("../controllers/quizRoutes");

dotenv.config();

connectDB();

const app = express();

app.use(express.json());
app.use(cors());

app.use("/media", express.static("media"));

app.use("/api/gpt", chatGPTRoutes);
app.use("/api/cards", cardsRoutes);
app.use("/api/quiz", quizRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

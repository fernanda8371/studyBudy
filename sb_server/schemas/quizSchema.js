const mongoose = require("mongoose");
const Schema = mongoose.Schema;

// Define the Quiz Schema
const quizSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },
    text: {
      type: [String], // Array of text items
      required: true,
      validate: [arrayLimit, "Text must have at least 1 element"], // Optional validation for minimum array length
    },
    answer: {
      type: [String], // Array of answers
      required: true,
      validate: [arrayLimit, "Answer must have at least 1 element"], // Optional validation for minimum array length
    },
    creation_date: {
      type: Date,
      default: Date.now, // Default to the current date if not provided
    },
  },
  {
    timestamps: true, // Adds `createdAt` and `updatedAt` fields automatically
  }
);

// Create and export the model
const Quiz = mongoose.model("Quiz", quizSchema);
module.exports = Quiz;

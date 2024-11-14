const mongoose = require("mongoose");

const cardSchema = new mongoose.Schema(
  {
    text: { type: String, required: true },
    creation_date: [{ type: Date, required: false }],
  },
  {
    collection: "cards",
  }
);

module.exports = mongoose.model("CARDS", cardSchema);

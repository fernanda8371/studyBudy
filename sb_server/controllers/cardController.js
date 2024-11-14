const CARDS = require("../schemas/cardSchema");

exports.getCards = async (req, res) => {
  try {
    const cards = await CARDS.find(); // Fetch all cards
    console.log("Cards found: ", cards); // Log the result to inspect data

    if (cards.length === 0) {
      console.log("No cards in the database");
    }

    res.status(200).json(cards); // Send the response back
  } catch (error) {
    console.error("Error fetching cards:", error);
    res.status(500).json({ message: error.message });
  }
};

exports.getCardById = async (req, res) => {
  const id = req.params.id;

  try {
    const card = await CARDS.findById(id);
    if (!card) {
      return res.status(404).json({ message: "Card no encontrado" });
    }
    res.status(200).json(card);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.crearCard = async (req, res) => {
  const { text, creation_date } = req.body; // Corrected to `card_owner`

  try {
    const nuevaCard = new CARDS({
      text,
      creation_date,
    });

    const cardCreated = await nuevaCard.save();
    return res.status(201).json({ message: "Carta creada", card: cardCreated });
  } catch (error) {
    res.status(500).json({ message: "Error al crear card " + error });
  }
};

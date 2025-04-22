require("dotenv").config();
console.log("Connecting to MongoDB URI:", process.env.MONGO_URI);
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB connected"))
  .catch((err) => console.error("MongoDB error:", err));


const scoreSchema = new mongoose.Schema({
  player: String,
  score: Number,
  date: { type: Date, default: Date.now },
});

const Score = mongoose.model("Score", scoreSchema);

app.post("/submit-score", async (req, res) => {
  const { player, score } = req.body;
  if (!player || score === undefined || score === null) {
    return res.status(400).send("Missing player or score");
  }

  try {
    const newScore = new Score({ player, score });
    await newScore.save();
    res.status(201).send("Score saved!");
  } catch (err) {
    res.status(500).send("Error saving score");
  }
});

app.get("/high-scores", async (req, res) => {
  try {
    const scores = await Score.find().sort({ score: -1 }).limit(10);
    res.json(scores);
  } catch (err) {
    res.status(500).send("Error fetching scores");
  }
});

app.listen(process.env.PORT || 3000, () => {
  console.log(`Server running on port ${process.env.PORT || 3000}`);
});

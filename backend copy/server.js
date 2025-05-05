require("dotenv").config(); // get variables from .env file
console.log("Connecting to MongoDB URI:", process.env.MONGO_URI); // prints mongoDB URI to confirm being read (used for debugging)
// import needed packages
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

// connets to MongoDB using the MONGO_URI from the .env file
mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB connected"))
  .catch((err) => console.error("MongoDB error:", err));


// creates how submission looks in database
const scoreSchema = new mongoose.Schema({
  player: String,         // player name
  score: Number,          // player score
  date: { type: Date, default: Date.now },    // time when score is submitted
});

// this is the collection
const Score = mongoose.model("Score", scoreSchema);

// creates endpoint to submit new score to
app.post("/submit-score", async (req, res) => {
  const { player, score } = req.body;
  if (!player || score === undefined || score === null) {
    return res.status(400).send("Missing player or score"); // only if player and score aren't provided
  }

  try {
    const newScore = new Score({ player, score });
    await newScore.save();
    res.status(201).send("Score saved!");
  } catch (err) {
    res.status(500).send("Error saving score"); // any database errors get caught
  }
});

// creates endpoint to display the 10 highest scores
app.get("/high-scores", async (req, res) => {
  try {
    // finds and returns 10 highest scores in descending order
    const scores = await Score.find().sort({ score: -1 }).limit(10);
    res.json(scores);
  } catch (err) {
    res.status(500).send("Error fetching scores");
  }
});

// starts server on port
app.listen(process.env.PORT || 3000, () => {
  console.log(`Server running on port ${process.env.PORT || 3000}`);
});

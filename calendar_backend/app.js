
const express = require("express");
const app = express();
const morgan = require("morgan");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");

const eventsRoute = require("./api/routes/events");
mongoose.connect("mongodb://eventsAdmin:" +
    process.env.MONGO_ATLAS_PW +
    "@events-rest-shard-00-00-bqhpc.mongodb.net:27017,events-rest-shard-00-01-bqhpc.mongodb.net:27017,events-rest-shard-00-02-bqhpc.mongodb.net:27017/test?ssl=true&replicaSet=events-rest-shard-0&authSource=admin&retryWrites=true"
);


app.use(morgan("dev"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  );
  if (req.method === 'OPTIONS') {
      res.header('Access-Control-Allow-Methods', 'PUT, POST, PATCH, DELETE, GET');
      return res.status(200).json({});
  }
  next();
});

// Routes which should handle requests
app.use("/events", eventsRoute);


app.use((req, res, next) => {
  const error = new Error("Not found");
  error.status = 404;
  next(error);
});

app.use((error, req, res, next) => {
  res.status(error.status || 500);
  res.json({
    error: {
      message: error.message
    }
  });
});

module.exports = app;
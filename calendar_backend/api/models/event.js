const mongoose = require("mongoose"); 
const eventSchema =  mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    title: String, 
    description: String, 
    startTime: Number, 
    endTime: Number, 
    day: Number, 
    month: Number, 
    year: Number,
    startTimeStr: String,
    endTimeStr: String
});

module.exports = mongoose.model("Event", eventSchema);
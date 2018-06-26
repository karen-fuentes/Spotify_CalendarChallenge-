const express = require('express');
const router = express.Router();
const Event = require("../models/event");
const mongoose = require("mongoose");
router.get('/', (req, res, next) => {
   
    Event.find()
    .exec()
    .then(docs => {
        res.status(200).json(docs);
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error:err})
    });
});

router.post('/', (req, res, next) => {
    const event = new Event({
        _id: new mongoose.Types.ObjectId(),
        title: req.body.title, 
        description: req.body.description, 
        startTime: parseFloat(req.body.startTime), 
        endTime: parseFloat(req.body.endTime), 
        day: parseInt(req.body.day), 
        month: parseInt(req.body.month), 
        year: parseInt(req.body.year),
        startTimeStr: req.body.startTimeStr,
        endTimeStr: req.body.endTimeStr
    });
    event.save()
    .then(result => {
        console.log(result);
        res.status(201).json({
            message: 'Handling POST requests to /events',
            createdEvent: result
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error:err})
    
    });

});

router.get('/:eventId', (req, res, next) => {
    const id = req.params.eventId;
    Event.findById(id)
    .exec()
    .then(doc => {
        console.log(doc);
        if(doc) {
            res.status(200).json(doc);
        } else {
            res.status(404).json({message:"no valid entry   found for provided id"}); 
        }
        
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error: err}); 
    });
});

router.patch('/:eventId', (req, res, next) => {
    const id = req.params.eventId;
    const updateOps = {};
    for(const ops of req.body) {
        updateOps[ops.propTitle] = ops.value
    }
    Event.update({_id:id},{$set:updateOps})
    .exec()
    .then(result => {
        console.log(result);
        res.status(200).json(result);
    })
    .catch(err =>{
        console.log(err);
        res.status(500).json({
            error:err
        });
    });
       
});

router.delete('/:eventId', (req, res, next) => {
    const id = req.params.eventId;
    Event.findOneAndRemove({_id: id})
    .exec()
    .then(result => {
        res.status(200).json(result);
    })
    .catch(err => {
        res.status(500).json({
            error:err
        });
    });
});

module.exports = router;
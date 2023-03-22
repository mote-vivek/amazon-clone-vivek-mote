const mongoose = require("mongoose");

const ratingSchema = ({
    userId: {
        type: String,
        required: true,
    },
    rating: {
        type: Number,
        required: true,
    }
});
module.exports = ratingSchema;
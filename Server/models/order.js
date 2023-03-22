const mongoose = require("mongoose");
const { productSchema } = require("./product");

const orderSchema = mongoose.Schema({
    products: [{
        product: productSchema,
        quantity: {
            type: Number,
            required: true,
        }
    }],
    totalPrice: {
        type: Number,
        required: true,
    },
    address: {
        type: String,
        required: true,
    },
    userId: {
        required: true,
        type: String,
    },
    orderedAt: {
        required: true,
        type: Number,
    },
    status: {
        type: Number,
        default: 0,
    }
});

const Order = mongoose.model("Orders", orderSchema);
module.exports = Order;
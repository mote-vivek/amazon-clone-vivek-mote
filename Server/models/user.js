const mongoose = require("mongoose");
const { productSchema } = require("./product");

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        trim: true,
        type: String,
        validate: {
            validator: (value) => {
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Please enter a valid email address",
        },
    },
    password: {
        required: true,
        type: String,
        validate: {
            validator: (val) => {
                return val.length >= 6;
            },
            message: "Password should be at least 6 characters long",
        }
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: "user",
    },
    cart: [{
        product: productSchema,
        quantity: {
            type: Number,
            required: true,
        }
    }],
})

const User = mongoose.model("User", userSchema);
module.exports = User;
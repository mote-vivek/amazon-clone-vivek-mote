const express = require("express");
const auth = require("../Middlewares/auth");
const { Product } = require("../models/product");
const ratingSchema = require("../models/rating");
const productRouter = express.Router();

//api/products?category=Essentials

productRouter.get("/api/products/", auth, async(req, res) => {
    try {
        const products = await Product.find({ category: req.query.category, }, );
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
}, );

//get request to fetch products
// /api/products/search/iPhone
productRouter.get("/api/products/search/:name", auth, async(req, res) => {
    try {
        const products = await Product.find({
            $or: [
                { name: { $regex: req.params.name, $options: "i" } },
                { description: { $regex: req.params.name, $options: "i" } },
            ],
        });
        res.json(products);
    } catch (e) {

    }
}, );

//post request route to rate the product
productRouter.post("/api/rate-product", auth, async(req, res) => {
    try {
        const { id, rating } = req.body;
        let product = await Product.findById(id);

        for (let i = 0; i < product.ratings.length; i++) {
            if (req.user == product.ratings[i].userId) {
                product.ratings.splice(i, 1);
                break;
            }
        }

        const ratingSchema = {
            userId: req.user,
            rating: rating,
        }

        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message, }, );
    }

});

productRouter.get("/api/deal-of-the-day", auth, async(req, res) => {
    try {
        let products = await Product.find({});
        products = products.sort((a, b) => {
            let aSum = 0;
            let bSum = 0;
            for (let i = 0; i < a.ratings.length; i++) {
                aSum += a.ratings[i].rating;
            }
            for (let i = 0; i < b.ratings.length; i++) {
                bSum += b.ratings[i].rating;
            }
            return aSum > bSum ? -1 : 1;
        }, );
        res.json(products[0]);
    } catch (e) {
        res.status(500).json({ error: e.message }, );
    }
}, );

module.exports = productRouter;
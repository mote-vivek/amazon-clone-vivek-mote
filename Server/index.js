console.log("Hello Vivek");
//Imports from packages
const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product")

//Imports from other files
const authRouter = require("./routes/auth");
const userRouter = require("./routes/user");

const PORT = process.env.PORT || 3000;
const app = express();
const DB = "mongodb+srv://vivek_mote:vivek%401234@cluster0.2tss4mx.mongodb.net/?retryWrites=true&w=majority";

//client-> middleware-> server-> client
//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//Connections
mongoose.connect(DB).then(() => {
    console.log("connection established");
}, ).catch((e) => {
    console.log(e);
}, );

//Sample API
// app.get("/hello-vivek", (req, res) => {
//     res.send("Hello vicky");
// }, );


//Creating an API

app.listen(PORT, "0.0.0.0", function() {
    console.log(`Connected at port ${PORT}`);
}, );
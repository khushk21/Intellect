const express = require("express");
const bodyParser = require("body-parser");
const firebase=require("firebase");
const nodemailer = require("nodemailer");

const cors=require("cors");
const app = express();

// PORT
const PORT = process.env.PORT || 8000;

// Middleware
app.use(bodyParser.json());
app.use(cors())
app.use(bodyParser.urlencoded({extended:true}))
app.post("/", (req, res) => {
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: req.body.sender,
      pass: 'CZ3003ssad'
    }
  });
  
  const mailOptions = {
    from: req.body.sender,
    to: req.body.email,
    subject: req.body.subject,
    text: req.body.text
  };
  
  transporter.sendMail(mailOptions, function(error, info){
    if (error) {
    console.log(error)
    } else {
      console.log('Email sent: ' + info.response);
    }
  });
  res.json({ message: "API Working" });
});

app.use("/api",require("./Routes/test"));
app.listen(PORT, (req, res) => {
  console.log(`Server Started at PORT ${PORT}`);
});

var express = require('express');
var bodyParser = require('body-parser');
var app = express();

app.all('/*', function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With", "Content-Type, Accept");
  res.header("Access-Control-Allow-Methods", "POST, GET");
  next();
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

var tutorials = [
  {
    id: 1,
    title: "Text Animation 1",
    description: "Learn how to install Android Studio and then go through this tutorial to build your very first app",
    iframe:'<div class="container"><iframe class="video" src="https://youtu.be/ehPLYGJ08hI" frameborder="0" allowfullscreen></iframe></div>',
    thumbnail: "http://res.cloudinary.com/dr9sypj5b/image/upload/v1472709931/Screen_Shot_2016-09-01_at_2.04.20_AM_xcsfr3.png"
  },
  {
    id: 2,
    title: "Text Animation 2",
    description: "Learn how to support multiple screen resolutions and devices such as iPhone 4, iPhone 5, iPhone 6, iPhone 6 Plus",
    thumbnail: "http://res.cloudinary.com/dr9sypj5b/image/upload/v1472709931/Screen_Shot_2016-09-01_at_2.04.48_AM_jszdze.png",
    iframe: '<div class="container"><iframe class="video" src="https://youtu.be/tRVflqWchdc" frameborder="0" allowfullscreen></iframe></div>'
  },
  {
    id: 3,
    title: "Stick man animation 1 using Maya",
    description: "Watch this super awesome and ridiculously basic stick animation using Maya",
    thumbnail: "http://res.cloudinary.com/dr9sypj5b/image/upload/v1472709934/Screen_Shot_2016-09-01_at_2.04.59_AM_znuvhm.png",
    iframe: '<div class="container"><iframe class="video" src="https://www.youtube.com/watch?v=Nv0YI_5FLxM" frameborder="0" allowfullscreen></iframe></div>'
  },
  {
    id: 4,
    title: "Stick man animation 2 using Maya",
    description: "Watch this super awesome and ridiculously basic stick animation using Maya",
    thumbnail: "http://res.cloudinary.com/dr9sypj5b/image/upload/v1472709934/Screen_Shot_2016-09-01_at_2.04.59_AM_znuvhm.png",
    iframe: '<div class="container"><iframe class="video" src="https://www.youtube.com/watch?v=mC7O8iahsyk" frameborder="0" allowfullscreen></iframe></div>'
  },
  {
    id: 5,
    title: "Stick man animation 3 using Maya",
    description: "Watch this super awesome and ridiculously basic stick animation using Maya",
    thumbnail: "http://res.cloudinary.com/dr9sypj5b/image/upload/v1472709934/Screen_Shot_2016-09-01_at_2.04.59_AM_znuvhm.png",
    iframe: '<div class="container"><iframe class="video" src="https://www.youtube.com/watch?v=g_WqxnfmhRk" frameborder="0" allowfullscreen></iframe></div>'
  }
];

var comments = [


];

var locations = [

    {
        name: "Bayside Marketplace",
        address: "401 Biscayne Blvd., R106, Miami, FL 33132"
    }

];


//app.put('/comments', function(req, res) {
//
//   var someOBJ = req.body;
//   var theId = someOBJ.uniqueId;
//
//    //talk to the database, find the record by the id
//    //then youreplace the existing record with req.body
//    res.send("Successfully updated");
//
//});

app.post('/comments', function(req,res) {

    var comment = req.body;

    if (comment) {

        if (comment.id && comment.commentBody) {

            comments.unshift(comment);
            res.send("You successfully posted a comment");

        }
        else {


            res.send("You posted invalid data");

        }

    }
    else {

        res.send("Your post has no body!");

    }

    console.log(comments);


});

app.get('/tutorials', function(req, res) {
  console.log("GET from server");
  res.send(tutorials);
});

app.get('/comments', function(req, res) {
  console.log("GET from server");
  res.send(comments);
});


app.listen(6069);

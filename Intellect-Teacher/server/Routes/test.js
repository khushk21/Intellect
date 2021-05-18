const express = require("express");
const firebase = require("firebase");
var router = express.Router();
var router2 = express.Router();
const app1 = firebase.initializeApp({
    apiKey: "",
    authDomain: "",
    projectId: "",
    storageBucket: "",
    messagingSenderId: "",
    appId: "",
});
router.get("/test", async (req, res) => {
  const db = app1.firestore();
  var indexList = [];
  const data = await db.collection("Teacher").get();
  data.docs.forEach((doc) => {
    if (doc.id == "noreplyteacher10@gmail.com") {
      var temp = doc.data();
      indexList = temp["index"];
    }
  });
  res.json({ data: indexList });
});
router.get("/students", async (req, res) => {
  const db = app1.firestore();
  var studentList = [];
  const data = await db
    .collection("Students")
    .where("class_index", "==", "SS1")
    .get();
  data.docs.forEach((doc) => {
    var temp = doc.data();
    studentList.push(doc.id);
  });
  res.json({ data: studentList });
});
router.get("/readQuestion", async (req, res) => {
  const db = app1.firestore();
  var questionList = [];
  const data = await db.collection("World 1").doc("Stage 1").get();
  var temp = data.data();
  var k=Object.keys(temp).length
  res.json({ data: k });
});

router.get("/addQuestion", async (req, res) => {
  const db = app1.firestore();
  const doc = await db.collection("World 3").doc("Stage 3").get();
  var k = doc.data();
  var len_initial = k["Hard"].length;
  k["Hard"].push({
    Answer: "0",
    Question: "0 + 0 - 0 x 0",
    Options: ["0", "1", "2", "3"],
  });
  var len_final = k["Hard"].length;
  const userRef = db
    .collection("World 3")
    .doc("Stage 3")
    .update({ Easy: k["Easy"], Medium: k["Medium"], Hard: k["Hard"] });
  res.json({ data: len_final - len_initial });
});

router.get("/checkProgress", async (req, res) => {
  const db = app1.firestore();
  var studentData = {};
  const data = await db
    .collection("Students")
    .doc("gopal19")
    .collection("World 1")
    .get();
  if (data.empty == false) {
    data.docs.forEach((doc) => {
      if (doc.id == "Stage 1") {
        var temp = doc.data()["Levels"];
        for (var i in temp) {
          if (i == "Easy") {
            studentData["Easy"] = temp[i];
            break;
          }
        }
      }
    });
  }
  res.json({ data: Object.keys(studentData["Easy"]).length });
});

router.get("/checkLogin", async (req, res) => {
  const db = app1.firestore();
  var verify = false;
  var useraccount = await db.collection("Students").doc("gopal19").get();
  if (useraccount.exists) {
    data = useraccount.data();
    if (data["password"] == "test") {
      verify = true;
    }
  }
  res.json({ data: verify });
});

router.get("/userDetail", async (req, res) => {
  const db = app1.firestore();
  var verify = false;
  db.collection("Students").doc("gopal19").update({ character: "Character 3" });
  const data = await db.collection("Students").doc("gopal19").get();
  var t = data.data();
  if (t["character"] == "Character 3") {
    verify = true;
  }
  res.json({ data: verify });
});

router.get("/battle", async (req, res) => {
  var verify = false;
  var currentLevel = "Hard";
  var currentStage = "Stage 1";
  var currentWorld = "World 1";
  var nextLevel = "";
  var nextStage = "";
  var nextWorld = "";
  if (currentLevel == "Easy") {
    nextLevel = "Medium";
    nextStage = currentStage;
    nextWorld = currentWorld;
  } else if (currentLevel == "Medium") {
    nextLevel = "Hard";
    nextStage = currentStage;
    nextWorld = currentWorld;
  } else {
    nextLevel = "Easy";
    if (currentStage == "Stage 1") {
      nextStage = "Stage 2";
      nextWorld = currentWorld;
    } else if (currentStage == "Stage 2") {
      nextStage = "Stage 3";
      nextWorld = currentWorld;
    } else {
      nextStage = "Stage 1";
      if (currentWorld == UserAccountMgr.worlds[0]) {
        nextWorld = UserAccountMgr.worlds[1];
      } else if (currentWorld == UserAccountMgr.worlds[1]) {
        nextWorld = UserAccountMgr.worlds[2];
      } else {
        nextWorld = null;
        nextStage = null;
        nextLevel = null;
      }
    }
  }
  if (
    (nextWorld = "World 1" && nextStage == "Stage 2" && nextLevel == "Easy")
  ) {
    verify = true;
  }
  res.json({ data: verify });
});

router.get("/updatePassword", async (req, res) => {
  const db = app1.firestore();
  var verify = false;
  const data = await db
    .collection("Students")
    .where("email", "==", "gopalagarwal1119@gmail.com")
    .get();
  data.docs.forEach((doc) => {
    var temp = doc.data();
    if (temp["email"] == "gopalagarwal1119@gmail.com") {
      db.collection("Students").doc(doc.id).update({ password: "test" });
    }
  });
  const data1 = await db.collection("Students").doc("gopal19").get();
  var t = data1.data();
  console.log(t);
  if (t["password"] == "test") {
    verify = true;
  }
  res.json({ data: verify });
});

router.get("/leaderboard", async (req, res) => {
  const db = app1.firestore();
  var l = 0;
  var d1 = {};
  const documents = await db.collection("Students").get();
  documents.docs.forEach(async (doc) => {
    const data = await db
      .collection("Students")
      .doc(doc.id)
      .collection("World 1")
      .doc("Stage 1")
      .get();

    if (data.data()["Levels"]["Easy"] != null) {
      d1[doc.id] = data.data()["Levels"]["Easy"]["score"];
      console.log(Object.keys(d1).length);
      res.json({ data: 1 });
    } else {
      res.json({ data: 0 });
    }
    return;
  });
});

router.get("/Challenge", async (req, res) => {
  const db = app1.firestore();
  var l = 0;
  const documents = await db
    .collection("Challenges")
    .where("sender", "==", "gopal19")
    .get();
  l = documents.docs.length;
  res.json({ data: l });
});
router.get("/assignment", async (req, res) => {
  const db = app1.firestore();
  var l = 0;
  const documents = await db
    .collection("Assignments")
    .where("class_index", "==", "SS1")
    .get();
  l = documents.docs.length;
  console.log(l);
  res.json({ data: l });
});

router.get("/loadTest", async (req, res) => {
  const db = app1.firestore();
  var start = new Date();
  var questionList = [];
  for (var i = 0; i < 100; i++) {
    const data = await db.collection("World 1").doc("Stage 1").get();
    var temp = data.data()["Easy"];
    questionList = temp;
  }
  var end = new Date();
  console.log((end - start) / 1000);
  res.json({ data: questionList.length });
});

module.exports = router;

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home_screen.dart';
import 'package:flutter_auth/Screens/level_cleared_screen.dart';
import 'package:flutter_auth/control/AssignmentMgr.dart';
import 'package:flutter_auth/control/BattleMgr.dart';
import 'package:flutter_auth/control/ChallengeMgr.dart';
import 'package:flutter_auth/control/QuestionsMgr.dart';
import 'package:flutter_auth/control/UserAccountMgr.dart';
import 'package:flutter_auth/entity/Questions.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:share/share.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class BattleScreen extends StatefulWidget {
  static const String id = 'battle_screen';

  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  String character;
  int monster = 1;
  int maxHP = 100;
  int maxTime = 50;
  int currentHP = 100;
  int totalQuestions;
  int currentQuestion = 1;
  int points = 0;
  static Size size;
  List<Questions> questionsList = [];
  Color flashBackground = Colors.white;
  String chosenAnswer;
  int questionNum = 0;
  int numCorrectQuestions = 0;
  String selectedWorld;
  String selectedStage;
  String selectedLevel;
  bool haveQuestions = false;
  final CountdownController _controller = new CountdownController();
  String mode;
  int timeLeft;
  Map extra = {};

  @override
  void initState() {
    super.initState();
    character = UserAccountMgr.studentDetails.character;
    if (character == "Character 2") {
      maxTime = 60;
    }
    if (character == "Character 3") {
      maxTime = 60;
      maxHP = 120;
      currentHP = 120;
    }
    UserAccountMgr.stopBackgroundMusic();
    BattleMgr.playMusic();
  }

  getQuestions() async {
    var temp = mode != "Assignment"
        ? await QuestionsMgr.readQuestions(
            selectedWorld, selectedStage, selectedLevel)
        : await QuestionsMgr.readAssignmentQuestions(selectedWorld);
    setState(() {
      questionsList = temp;
      haveQuestions = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Map temp = ModalRoute.of(context).settings.arguments;
    selectedWorld = temp['world'];
    selectedStage = temp['stage'];
    selectedLevel = temp['level'];
    mode = temp['mode'];
    extra = temp['extra'];
    if (!haveQuestions) {
      getQuestions();
    }
    print("questionsList = $questionsList");
    setState(() {
      totalQuestions = questionsList.length;
    });
    return Scaffold(
        body: haveQuestions
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildHP(maxHP, currentHP),
                          ],
                        ),
                      ),
                      _buildScore(),
                      _buildTimer(),
                      _buildQuestionCard()
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCharacter(character, 0.65, 0.25),
                      _buildQuestion(questionsList[questionNum]),
                      _buildMonster(monster, 0.65, 0.25),
                    ],
                  ),
                ],
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator())));
  }

  Widget _buildScore() {
    return Container(
      width: size.width * 0.10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.sports_esports),
          Text(
            '$points',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.07,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      width: size.width * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.question_answer),
          Text(
            '${questionNum + 1} / $totalQuestions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.07,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimer() {
    return Container(
      width: size.width * 0.1,
      height: size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.timer),
            Countdown(
              controller: _controller,
              seconds: maxTime,
              build: (BuildContext context, double time) {
                timeLeft = time.toInt();
                return Text(
                  time.toInt().toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.07,
                    color: Colors.red,
                  ),
                );
              },
              onFinished: () {
                endGame();
                print('Timer is done!');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHP(int maxHP, int currentHP) {
    double percent = (currentHP / maxHP) * 100;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: RoundedProgressBar(
        borderRadius: BorderRadius.circular(6),
        theme: RoundedProgressBarTheme.red,
        percent: percent,
      ),
    );
  }

  Widget _buildCharacter(
      String imageName, double heightMultiplier, double widthMultiplier) {
    double height = size.height * heightMultiplier;
    double width = size.width * widthMultiplier;
    return Container(
      height: height,
      width: width,
      child: ColumnSuper(
        alignment: Alignment.center,
        invert: true,
        innerDistance: -height * 0.2,
        children: [
          Container(
            height: height * 0.9,
            width: width * 0.9,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/characters/$imageName.png'),
              ),
            ),
          ),
          Container(
            height: height * 0.25,
            width: width * 0.5,
            decoration: BoxDecoration(
              color: Color(0xff8ad78e),
              borderRadius: BorderRadius.all(
                  Radius.elliptical(width * 0.5, height * 0.25)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonster(
      int imageName, double heightMultiplier, double widthMultiplier) {
    double height = size.height * heightMultiplier;
    double width = size.width * widthMultiplier;
    return Container(
      height: height,
      width: width,
      child: ColumnSuper(
        alignment: Alignment.center,
        invert: true,
        innerDistance: -height * 0.2,
        children: [
          Container(
            height: height * 0.9,
            width: width * 0.9,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                    'assets/images/monsters/monster ${imageName.toString()}.png'),
              ),
            ),
          ),
          Container(
            height: height * 0.25,
            width: width * 0.5,
            decoration: BoxDecoration(
              color: Color(0xff8ad78e),
              borderRadius: BorderRadius.all(
                  Radius.elliptical(width * 0.5, height * 0.25)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(Questions questionObj) {
    String question = questionObj.question;
    String correctAnswer = questionObj.answer;
    List<String> options = questionObj.options;

    double height = size.height * 0.6;
    double width = size.width * 0.4;
    double padding = width * 0.03;
    return Container(
      height: height,
      width: width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Question:  " + question + "?",
            style: TextStyle(fontSize: 18),
          ),
          Table(
            border: TableBorder.all(color: Colors.black),
            children: [
              TableRow(
                children: [
                  _buildOptions(
                      padding, width * 0.8, "a. ", options[0], correctAnswer)
                ],
              ),
              TableRow(
                children: [
                  _buildOptions(
                      padding, width * 0.8, "b. ", options[1], correctAnswer)
                ],
              ),
              TableRow(
                children: [
                  _buildOptions(
                      padding, width * 0.8, "c. ", options[2], correctAnswer)
                ],
              ),
              TableRow(
                children: [
                  _buildOptions(
                      padding, width * 0.8, "d. ", options[3], correctAnswer)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptions(double padding, double width, String index, String value,
      String correctAnswer) {
    return Container(
      color: chosenAnswer == value ? flashBackground : Colors.white,
      child: GestureDetector(
        onTap: () {
          setState(() {
            chosenAnswer = value;
          });
          print(chosenAnswer);
          setState(() {
            currentHP =
                chosenAnswer != correctAnswer ? currentHP - 20 : currentHP;
            points = chosenAnswer == correctAnswer ? points + 10 : points;

            numCorrectQuestions = chosenAnswer == correctAnswer
                ? numCorrectQuestions + 1
                : numCorrectQuestions;
            if (numCorrectQuestions == totalQuestions) {
              points = points + 30;
            }
            if (currentHP <= 0) {
              endGame();
            }
            flashBackground = (chosenAnswer == correctAnswer.toString()
                ? Colors.green
                : Colors.red);
            Timer(Duration(seconds: 1), () {
              setState(() {
                flashBackground = Colors.white;
                monster = monster < 10 ? monster + 1 : 10;
                questionNum < totalQuestions - 1 ? questionNum++ : endGame();
              });
            });
          });
        },
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Row(
            children: [
              Text(
                index,
              ),
              Container(
                width: width * 0.9,
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void endGame() async {
    _controller.onPause();
    print("hi");
    BattleMgr.stopMusic();
    await UserAccountMgr.playBackgroundMusic();
    mode == 'Solo Campaign'
        ? endGameSCM()
        : mode == "Challenge"
            ? endGameChallenge()
            : mode == "ChallengePlay"
                ? endGameChallengePlay()
                : endGameAssignment();
  }

  void endGameChallengePlay() {
    BattleMgr.updateChallengeScore(extra['chalenge_id'], points);
    showDialog(
        context: context,
        builder: (BuildContext context) => buildPopUp(
            "Challenge Completed",
            points > extra['score_to_beat']
                ? "Congratulation, you win!"
                : points < extra['score_to_beat']
                    ? "Sorry, you lost this battle"
                    : "ooo, scores are tied!",
            "Hey, I've attempted the challenge"));
  }

  void endGameSCM() {
    print("time= ${timeLeft.toString()}");
    BattleMgr.compileResultSoloCampaign(selectedWorld, selectedStage,
        selectedLevel, maxTime - timeLeft, points, numCorrectQuestions);
    Navigator.popAndPushNamed(context, LevelCleared.id, arguments: {
      "world": selectedWorld,
      "stage": selectedStage,
      "level": selectedLevel,
      "time": maxTime - timeLeft,
      "score": points,
      "numCorrectQuestions": numCorrectQuestions,
      "totalQuestions": totalQuestions,
      "health": currentHP,
      "status": numCorrectQuestions >= 5 ? true : false
    });
  }

  void endGameChallenge() {
    ChallengeMgr.createChallenge(
        selectedWorld, selectedStage, selectedLevel, points, extra['player']);
    showDialog(
        context: context,
        builder: (BuildContext context) => buildPopUp(
            'Challenge Sent',
            "Your score: $points",
            "Hey! Check out the challenge I just sent you! My score is $points."));
  }

  buildPopUp(String title, String body, String shareMsg) {
    return AlertDialog(
      title: Text(title),
      content: Column(mainAxisSize: MainAxisSize.min, children: [Text(body)]),
      actions: [
        new TextButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName(HomeScreen.id));
            },
            child: Text("OK")),
        new TextButton(
            onPressed: () {
              Share.share(shareMsg);
            },
            child: Text("SHARE")),
      ],
    );
  }

  void endGameAssignment() {
    AssignmentMgr.addClearedStudent(points, extra['assignment_id']);
    showDialog(
        context: context,
        builder: (BuildContext context) => buildPopUp('Assignment complete',
            "Your score: $points", "Hey! I've completed the assignment"));
  }
}

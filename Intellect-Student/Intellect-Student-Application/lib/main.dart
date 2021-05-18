import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/challenge_received_history.dart';
import 'package:flutter_auth/Screens/challenge_sent_history.dart';
import 'package:flutter_auth/Screens/create_new_challenge.dart';
import 'package:flutter_auth/Screens/assignment_screen.dart';
import 'package:flutter_auth/Screens/challenges_screen.dart';
import 'package:flutter_auth/Screens/character_screen.dart';
import 'package:flutter_auth/Screens/first_time_login.dart';
import 'package:flutter_auth/Screens/forgot_screen.dart';
import 'package:flutter_auth/Screens/home_screen.dart';
import 'package:flutter_auth/Screens/leaderboard_filter_screen.dart';
import 'package:flutter_auth/Screens/leaderboard_screen.dart';
import 'package:flutter_auth/Screens/level_cleared_screen.dart';
import 'package:flutter_auth/Screens/new_assignment_screen.dart';
import 'package:flutter_auth/Screens/otp_screen.dart';
import 'package:flutter_auth/Screens/past_assignment_screen.dart';
import 'package:flutter_auth/Screens/pending_challenges_screen.dart';
import 'package:flutter_auth/Screens/select_level.dart';
import 'package:flutter_auth/Screens/select_stage.dart';
import 'package:flutter_auth/Screens/settings_screen.dart';
import 'package:flutter_auth/Screens/welcome_screen.dart';
import 'package:flutter_auth/Screens/worlds_screen.dart';
import 'package:flutter_auth/Screens/battle_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth/Screens/reset_screen.dart';
import 'package:flutter_auth/Screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intellect',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ResetScreen.id: (context) => ResetScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        CharacterScreen.id: (context) => CharacterScreen(),
        OtpScreen.id: (context) => OtpScreen(),
        ForgotPassword.id: (context) => ForgotPassword(),
        WorldsScreen.id: (context) => WorldsScreen(),
        SelectStage.id: (context) => SelectStage(),
        SelectLevel.id: (context) => SelectLevel(),
        BattleScreen.id: (context) => BattleScreen(),
        SelectLevel.id: (context) => SelectLevel(),
        AssignmentScreen.id: (context) => AssignmentScreen(),
        NewAssignmentScreen.id: (context) => NewAssignmentScreen(),
        FirstLogin.id: (context) => FirstLogin(),
        PastAssignmentScreen.id: (context) => PastAssignmentScreen(),
        ChallengeScreen.id: (context) => ChallengeScreen(),
        ChallengeSentHistory.id: (context) => ChallengeSentHistory(),
        ChallengeReceivedHistory.id: (context) => ChallengeReceivedHistory(),
        PendingChallengesScreen.id: (context) => PendingChallengesScreen(),
        CreateNewChallengeScreen.id: (context) => CreateNewChallengeScreen(),
        LevelCleared.id: (context) => LevelCleared(),
        SettingsScreen.id: (context) => SettingsScreen(),
        Leaderboard.id: (context) => Leaderboard(),
        LeaderBoardFilterScreen.id: (context) => LeaderBoardFilterScreen(),
      },
    );
  }
}

class Challenge {
  Map _question;
  String _challengeId;
  String _sender;
  String _receiver;
  int _myScore;
  int _receiverScore;
  Challenge(
      {Map question,
      String challengeId,
      String receiver,
      String sender,
      int myScore,
      int receiverScore})
      : _question = question,
        _challengeId = challengeId,
        _receiver = receiver,
        _sender = sender,
        _myScore = myScore,
        _receiverScore = receiverScore;
  Map get question => _question;
  String get challengeId => _challengeId;
  String get sender => _sender;
  String get receiver => _receiver;
  int get myScore => _myScore;
  int get receiverScore => _receiverScore;
  set question(Map question) {
    _question = question;
  }

  set challengeId(String challengeId) {
    _challengeId = challengeId;
  }

  set sender(String sender) {
    _sender = sender;
  }

  set receiver(String receiver) {
    _receiver = receiver;
  }

  set myScore(int myScore) {
    _myScore = myScore;
  }

  set receiverScore(int receiverScore) {
    _receiverScore = receiverScore;
  }
}

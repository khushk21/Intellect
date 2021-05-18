class Assignment {
  String _assignmentCode;
  List<dynamic> _cleared;
  String _index;
  List<String> _studentsAttempted;
  String _title;
  String _world;
  String _dueDate;
  Assignment(
      {String assignmentCode,
      String index,
      List<dynamic> cleared,
      List<String> studentsAttempted,
      String title,
      String world,
      String dueDate,
      String id})
      : _assignmentCode = assignmentCode,
        _index = index,
        _studentsAttempted = studentsAttempted,
        _cleared = cleared,
        _title = title,
        _world = world,
        _dueDate = dueDate;
  String get assignmentCode => _assignmentCode;
  List<dynamic> get cleared => _cleared;
  String get index => _index;
  String get world => _world;
  String get dueDate => _dueDate;
  List<String> get studentsAttempted => _studentsAttempted;
  String get title => _title;

  set assignmentCode(String assignmentCode) {
    _assignmentCode = assignmentCode;
  }

  set cleared(List<dynamic> cleared) {
    _cleared = cleared;
  }

  set index(String index) {
    _index = index;
  }

  set title(String title) {
    _title = title;
  }

  set world(String world) {
    _world = world;
  }

  set dueDate(String dueDate) {
    _dueDate = dueDate;
  }

  set studentsAttempted(List<String> studentsAttempted) {
    _studentsAttempted = studentsAttempted;
  }
}

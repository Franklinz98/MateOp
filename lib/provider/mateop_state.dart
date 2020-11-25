import 'package:flutter/foundation.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/user.dart';

class MateOpState extends ChangeNotifier {
  MOUser _user;
  ExerciseManager _exerciseManager;
  String _dataPath;
  MainScreen _mainScreen = MainScreen.home;
  OperationType _operationType;

  String get localPath => _dataPath;
  MOUser get user => _user;
  String get userId => _user.firebaseUser.uid;
  ExerciseManager get exerciseManager => _exerciseManager;
  MainScreen get mainScreen => _mainScreen;
  OperationType get operation => _operationType;

  void setOperation(OperationType operationType) {
    _operationType = operationType;
  }

  void setMainScreen(MainScreen screen) {
    _mainScreen = screen;
  }

  void setMainScreenLoud(MainScreen screen) {
    _mainScreen = screen;
    notifyListeners();
  }

  void setUser(MOUser user) {
    _user = user;
    notifyListeners();
  }

  void updatePath(String path) {
    _dataPath = path;
  }

  void updateExerciseManager(ExerciseManager exerciseManager) {
    _exerciseManager = exerciseManager;
  }
}

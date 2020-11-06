import 'package:flutter/foundation.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/user.dart';

class MateOpState extends ChangeNotifier {
  MOUser _user;
  ExerciseManager _exerciseManager;
  String _dataPath;

  String get localPath => _dataPath;
  MOUser get user => _user;
  String get userId => _user.firebaseUser.uid;
  ExerciseManager get exerciseManager => _exerciseManager;

  void setUser(MOUser user) {
    _user = user;
  }

  void updatePath(String path) {
    _dataPath = path;
  }

  void updateExerciseManager(ExerciseManager exerciseManager) {
    _exerciseManager = exerciseManager;
  }
}

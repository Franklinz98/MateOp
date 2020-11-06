import 'dart:math';

import 'package:mate_op/models/exercise.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/user.dart';
import 'package:mate_op/provider/mateop_state.dart';

import 'exercise_generator.dart';

onReadyButtonPress(double playerAnswer, Duration duration, int hesitations,
    MateOpState state) async {
  if (playerAnswer != double.infinity) {
    Exercise exercise = state.exerciseManager.getCurrentExercise();
    exercise.playerAnswer = playerAnswer;
    exercise.duration = duration;
    state.exerciseManager.finalTime += duration;
    exercise.hesitations = hesitations;
    if (exercise.playerAnswer != exercise.answer) {
      writeOnFIleWrongExercise(exercise, state.localPath);
    }
    state.exerciseManager.nextExercise();
  }
}

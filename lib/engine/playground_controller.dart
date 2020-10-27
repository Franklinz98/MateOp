import 'dart:math';

import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/models/exercise.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/user.dart';

import 'exercise_generator.dart';

onReadyButtonPress(double playerAnswer, Duration duration, int hesitations,
    ExerciseManager exerciseManager, MOUser user) async {
  if (playerAnswer != double.infinity) {
    Exercise exercise = exerciseManager.getCurrentExercise();
    exercise.playerAnswer = playerAnswer;
    exercise.duration = duration;
    exerciseManager.finalTime += duration;
    exercise.hesitations = hesitations;
    if (exercise.playerAnswer != exercise.answer) {
      await writeOnFIleWrongExercise(exercise);
      exerciseManager.nextExercise();
    } else {
      exerciseManager.nextExercise();
    }
    writeSessionFile(exerciseManager, user);
  }
}

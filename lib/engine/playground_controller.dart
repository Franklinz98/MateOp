import 'dart:math';

import 'package:mate_op/engine/exercise_generator.dart';
import 'package:mate_op/models/exercise.dart';
import 'package:mate_op/models/exercise_manager.dart';

class PlaygroundController {
  onReadyButtonPress(double playerAnswer, Duration duration, int hesitations) {
    ExerciseManager exerciseManager = ExerciseManager(); //Exercisemanager of provider, playerAnswer y hesitations
    if (playerAnswer != double.infinity) {
      Exercise exercise = exerciseManager.getCurrentExercise();
      exercise.playerAnswer = playerAnswer;
      exercise.duration = duration;
      exerciseManager.finalTime += duration;
      exercise.hesitations = hesitations;
      if (exercise.playerAnswer != exercise.answer) {
        writeOnFIleWrongExercise(exercise);
      } else {
        exerciseManager.nextExercise();
      }
    }
  }

  onOptionSwap(double playerAnswer) {
    double hes = 0;
    hes += 1; //Hesitation of provider
    // Asign playerAnswer to provider counterpart
  }
}

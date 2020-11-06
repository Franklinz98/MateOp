import 'dart:io';
import 'dart:math';

import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/engine/exercise_generator.dart';
import 'package:mate_op/engine/playground_controller.dart';
import 'package:mate_op/engine/score_controller.dart';
import 'package:mate_op/models/exercise.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/user.dart';
import 'package:mate_op/provider/mateop_state.dart';

class Playground {
  ExerciseManager exerciseManager;
  int hesitations = 0;
  int playerAnswer;
  Exercise currentExercise;
  MOUser user;

  void startSession(MateOpState state) async {
    do {
      _showExercise();
      writeSessionFile(state.localPath, state.exerciseManager, state.userId);
      var playerAnswer = currentExercise.answer.toString();
      if (Random().nextDouble() > 0.75) {
        playerAnswer = '-1';
      }
      /* var playerAnswer = double.infinity.toString();
      while (!ready) {
        playerAnswer = stdin.readLineSync();
        print('listo? Y/n');
        ready = stdin.readLineSync() == 'Y';
        hesitations++;
      } */
      print(exerciseManager.currentExercise);
      if (Random().nextDouble() > 0.98) {
        print('cut session');
        break;
      }
      await onReadyButtonPress(
          double.parse(playerAnswer),
          Duration(seconds: Random().nextInt(10) + 5),
          Random().nextInt(2),
          state);
      if (exerciseManager.isTestFinished()) {
        user.session++;
        updateFileWithVectorPerformace(state);
        // print(
            // 'done ${user.session} - WinRate: ${exerciseManager.getPorcentGoodAnswers()} - Stars: ${exerciseManager.getStarsCount()} - Score: ${exerciseManager.getSessionScore()}');
      }
    } while (!exerciseManager.isTestFinished());
  }

  void _showExercise() {
    currentExercise = exerciseManager.getCurrentExercise();
    print(
        '${currentExercise.firstOperator} + ${currentExercise.secondOperator} = ?');
    print(generateAnswerOptions(currentExercise.answer));
  }
}

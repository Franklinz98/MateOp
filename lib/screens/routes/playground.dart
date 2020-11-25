import 'package:flutter/material.dart';
import 'package:mate_op/engine/exercise_generator.dart';
import 'package:mate_op/engine/score_controller.dart';
import 'package:mate_op/models/exercise.dart';
import 'package:mate_op/provider/mateop_state.dart';
import 'package:mate_op/screens/views/game_zone.dart';
import 'package:mate_op/screens/views/results.dart';
import 'package:provider/provider.dart';

class PlayGround extends StatefulWidget {
  @override
  _PlayGroundState createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  MateOpState state;
  Widget _content;

  @override
  void initState() {
    super.initState();
    state = Provider.of<MateOpState>(context, listen: false);
    _content = GameZone(
      state: state,
      nextExercise: onReadyButtonPress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/background_b.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          _content
        ],
      ),
    );
  }

  onReadyButtonPress(
    double playerAnswer,
    Duration duration,
    int hesitations,
  ) {
    Exercise exercise = state.exerciseManager.getCurrentExercise();
    exercise.playerAnswer = playerAnswer;
    exercise.duration = duration;
    state.exerciseManager.finalTime += duration;
    exercise.hesitations = hesitations;
    if (exercise.playerAnswer != exercise.answer) {
      saveWrongExercisesOnFile(exercise, state.localPath);
    }
    if (state.exerciseManager.isTestFinished()) {
      state.user.increaseSession(state.operation);
      updateFileWithVectorPerformace(state);
      setState(() {
        _content = SessionResults(results: state.exerciseManager.getResults());
      });
    } else {
      state.exerciseManager.nextExercise();
    }
  }
}

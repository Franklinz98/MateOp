import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/animations/planets/blue_shades.dart';
import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/components/moon.dart';
import 'package:mate_op/animations/planets/orange.dart';
import 'package:mate_op/animations/planets/pink.dart';
import 'package:mate_op/components/timer_bar.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/engine/exercise_generator.dart';
import 'package:mate_op/models/exercise.dart';
import 'package:mate_op/provider/mateop_state.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GameZone extends StatefulWidget {
  final Function nextExercise;
  final MateOpState state;

  const GameZone({Key key, @required this.state, @required this.nextExercise})
      : super(key: key);

  @override
  _GameZoneState createState() => _GameZoneState();
}

class _GameZoneState extends State<GameZone> {
  Exercise exercise;
  String firstOp, secondOp;
  Duration duration;
  TimerBar timerBar;
  double op1, op2, op3, playerAnswer;
  int hesitation;

  @override
  void initState() {
    super.initState();
    hesitation = -1;
    playerAnswer = double.minPositive;
    duration = Duration();
    timerBar = TimerBar(durationUpdate: (Duration increment) {
      duration += increment;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    showExercise();
    return SafeArea(
      child: Stack(
        children: [
          BlueShadesPlanetAnim(
            screenSize: screenSize,
            size: Size(130, 130),
            margin: Size(80, -35),
            angle: 0,
            positionOffset: Size(0, 5),
            alignment: AnimAlignment.centerLeft,
            duration: Duration(seconds: 2),
            type: AnimType.parent,
            child: Text(
              firstOp,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                fontSize: 38,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.54),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          PinkPlanetAnim(
            screenSize: screenSize,
            size: Size(130, 130),
            margin: Size(0, -35),
            angle: 0,
            positionOffset: Size(0, -5),
            alignment: AnimAlignment.center,
            duration: Duration(seconds: 2),
            type: AnimType.parent,
            child: Text(
              secondOp,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                fontSize: 38,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.54),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          OrangePlanetAnim(
            screenSize: screenSize,
            size: Size(130, 130),
            margin: Size(80, -35),
            angle: 0,
            positionOffset: Size(0, 5),
            alignment: AnimAlignment.centerRight,
            duration: Duration(seconds: 2),
            type: AnimType.parent,
            child: Text(
              "?",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 38,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.54),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                timerBar,
                SizedBox(
                  height: 24.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "+",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "=",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MoonPlanet(
                      size: Size(
                        75.0,
                        75.0,
                      ),
                      child: Text(
                        op1.toInt().toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          color: Color(0xff001e7e),
                          shadows: [
                            Shadow(
                              offset: Offset(0.00, 3.00),
                              color: Color(0xff000000).withOpacity(0.54),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      onTap: () => selectOption(op1),
                    ),
                    MoonPlanet(
                      size: Size(
                        75.0,
                        75.0,
                      ),
                      child: Text(
                        op2.toInt().toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          color: Color(0xff001e7e),
                          shadows: [
                            Shadow(
                              offset: Offset(0.00, 3.00),
                              color: Color(0xff000000).withOpacity(0.54),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      onTap: () => selectOption(op2),
                    ),
                    MoonPlanet(
                      size: Size(
                        75.0,
                        75.0,
                      ),
                      child: Text(
                        op3.toInt().toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          color: Color(0xff001e7e),
                          shadows: [
                            Shadow(
                              offset: Offset(0.00, 3.00),
                              color: Color(0xff000000).withOpacity(0.54),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      onTap: () => selectOption(op3),
                    ),
                    MoonPlanet(
                      size: Size(
                        75.0,
                        75.0,
                      ),
                      child: Text(
                        "X",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          color: Color(0xff001e7e),
                          shadows: [
                            Shadow(
                              offset: Offset(0.00, 3.00),
                              color: Color(0xff000000).withOpacity(0.54),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      onTap: () => selectOption(-double.minPositive),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42.0,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MoonPlanet(
              size: Size(
                90.0,
                90.0,
              ),
              child: Icon(
                Icons.check_outlined,
                color: Color(0xff001e7e),
                size: 35.0,
              ),
              onTap: () {
                if (playerAnswer != double.minPositive) {
                  timerBar.stopTicker();
                  print(duration.inSeconds);
                  setState(() {
                    widget.nextExercise
                        .call(playerAnswer, duration, hesitation);
                    hesitation = -1;
                    playerAnswer = double.minPositive;
                    duration = Duration();
                    timerBar.startTicker();
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void restartTicker() {
    timerBar.stopTicker();
    timerBar.startTicker();
  }

  void showExercise() {
    exercise = widget.state.exerciseManager.getCurrentExercise();
    print('Exercise: ${widget.state.exerciseManager.currentExercise}');
    exercise.answerOptions = generateAnswerOptions(exercise.answer);
    writeSessionFile(widget.state.localPath, widget.state.exerciseManager,
        widget.state.userId);
    firstOp = exercise.firstOpInt;
    secondOp = exercise.secondOpInt;
    op1 = exercise.answerOptions[0];
    op2 = exercise.answerOptions[1];
    op3 = exercise.answerOptions[2];
  }

  void selectOption(double value) {
    if (playerAnswer != value) {
      playerAnswer = value;
      hesitation++;
      print(playerAnswer);
      print(hesitation);
    }
  }
}

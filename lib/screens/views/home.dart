import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/animations/astronaut/astronaut.dart';
import 'package:mate_op/animations/rockets/rocket_a.dart';
import 'package:mate_op/backend/firebase/authentication.dart';
import 'package:mate_op/backend/firebase/data.dart';
import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/backend/service/service.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/engine/exercise_generator.dart';
import 'package:mate_op/engine/playground.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/intensities.dart';
import 'package:mate_op/models/performance_vectors.dart';
import 'package:mate_op/models/user.dart';
import 'package:mate_op/provider/mateop_state.dart';
import 'package:mate_op/screens/routes/authentication.dart';
import 'package:mate_op/screens/routes/playground.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String imagesUri = "assets/images";
  final MateOpState state;

  const Home({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 90,
            top: 55,
            child: Transform.rotate(
              angle: 42 * pi / 180.0,
              child: Image.asset(
                "assets/images/rocket_asset.png",
                height: 162,
                width: 50,
              ),
            ),
          ),
          Positioned(
            right: 55,
            top: 90,
            child: Transform.rotate(
              angle: 31 * pi / 180.0,
              child: Image.asset(
                "assets/images/astronaut_asset.png",
                height: 150,
                width: 212,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  this.state.user != null
                      ? "Hola ${this.state.user.firebaseUser.displayName}!"
                      : "Hola User!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: Colors.white),
                ),
                GestureDetector(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image.asset("$imagesUri/moon_asset.png"),
                      Image.asset("$imagesUri/play_icon.png"),
                    ],
                  ),
                  onTap: () async {
                    User firebaseUser = currentUser();
                    if (firebaseUser == null) {
                      MOUser user;
                      user = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authentication()),
                      );
                      state.setUser(user);
                    }
                    startSession(context);
                  },
                ),
                Text(
                  "Juguemos...",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(fontSize: 28, color: Colors.white),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 24.0),
                child: Image.asset("$imagesUri/cup_icon.png"),
              ),
              onTap: () {
                this.state.setMainScreenLoud(MainScreen.ranking);
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 24.0),
                child: Image.asset("$imagesUri/cog_icon.png"),
              ),
              onTap: () {
                // setTimes();
                signOut().then((value) => this.state.setUser(null));
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> startSession(BuildContext context) async {
    if (getLocalFile(state.localPath, 'session_file_${state.userId}')
        .existsSync()) {
      state.updateExerciseManager(
          readSessionFile(state.localPath, state.userId));
      openGameZone(context, state);
    } else {
      if (state.user.performanceJson) {
        Map performanceData = await getPerformanceData(state.user);
        Intensity intensity = await getNextIntensityLevel(performanceData);
        List exercises =
            generateExercisesFromLOPerformance(intensity, 15, state.localPath);
        state.updateExerciseManager(ExerciseManager(
            allExercises: exercises,
            currentExercise: 0,
            finalTime: Duration()));
        openGameZone(context, state);
      } else {
        Intensity intensity = await predictInicitalIntensity(state.user);
        List exercises =
            generateExercisesFromLOPerformance(intensity, 15, state.localPath);
        state.updateExerciseManager(ExerciseManager(
          allExercises: exercises,
          currentExercise: 0,
          finalTime: Duration(),
        ));
        PerformanceVectors performanceVectors = PerformanceVectors();
        // performanceVectors.jsonIntensities =
        performanceVectors.grado = state.user.grade;
        performanceVectors.sesion = state.user.session;
        performanceVectors.tipoEscuela = state.user.schoolType;
        performanceVectors.setBinperPerformanceVectors([
          [1, 0],
          [1, 0],
          [1, 0],
          [1, 0],
          [1, 0]
        ]);
        performanceVectors.writeObjectInFile(state.localPath);
        openGameZone(context, state);
      }
    }
  }

  void openGameZone(BuildContext context, MateOpState state) {
    print('nueva Ruta');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<MateOpState>.value(
          value: state,
          child: PlayGround(),
        ),
      ),
    );
  }
}

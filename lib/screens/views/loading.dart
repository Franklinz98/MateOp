import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/animations/astronaut/astronaut.dart';
import 'package:mate_op/backend/firebase/data.dart';
import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/backend/service/service.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/engine/exercise_generator.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/intensities.dart';
import 'package:mate_op/models/performance_vectors.dart';
import 'package:mate_op/provider/mateop_state.dart';
import 'package:path/path.dart' as p;

class LoadingScreen extends StatelessWidget {
  final String imagesUri = "assets/images";
  final MateOpState state;
  final Function openPlayground;

  const LoadingScreen(
      {Key key, @required this.state, @required this.openPlayground})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    startSession().then((value) {
      this.openPlayground.call();
    });
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            AstronautAnim(
              screenSize: screenSize,
              size: Size(245, 124.6),
              margin: Size(0, 0),
              angle: 0,
              positionOffset: Size(5, 8),
              alignment: AnimAlignment.center,
              duration: Duration(seconds: 3),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hola ${this.state.user.firebaseUser.displayName}!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Text(
                    "Obteniendo ejercicios...",
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.nunito(fontSize: 28, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startSession() async {
    if (getLocalFile(state.localPath,
            'session_file_${p.extension(state.operation.toString()).replaceAll('.', '')}_${state.userId}')
        .existsSync()) {
      state.updateExerciseManager(
          readSessionFile(state.localPath, state.operation, state.userId));
    } else {
      bool performaceExist =
          await checkPerformanceData(state.user, state.operation);
      if (performaceExist) {
        Map performanceData =
            await getPerformanceData(state.user, state.operation);
        Intensity intensity = await getNextIntensityLevel(
            performanceData, state.operation, state.user.token);
        List exercises = generateExercisesFromPerformance(
            intensity, 15, state.localPath, state.operation);
        state.updateExerciseManager(ExerciseManager(
            allExercises: exercises,
            currentExercise: 0,
            finalTime: Duration()));
      } else {
        Intensity intensity =
            await predictInicitalIntensity(state.user, state.user.token);
        List exercises = generateExercisesFromPerformance(
            intensity, 15, state.localPath, state.operation);
        state.updateExerciseManager(ExerciseManager(
          allExercises: exercises,
          currentExercise: 0,
          finalTime: Duration(),
        ));
        PerformanceVectors performanceVectors = PerformanceVectors();
        // performanceVectors.jsonIntensities =
        performanceVectors.grado = state.user.grade;
        performanceVectors.sesion = state.user.getSession(state.operation);
        performanceVectors.tipoEscuela = state.user.schoolType;
        performanceVectors.setBinperPerformanceVectors([
          [1, 0],
          [1, 0],
          [1, 0],
          [1, 0],
          [1, 0]
        ]);
        performanceVectors.writeObjectInFile(state.localPath, state.operation);
      }
    }
  }
}

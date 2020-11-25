import 'package:mate_op/backend/firebase/data.dart';
import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/performance_vectors.dart';
import 'package:mate_op/models/user.dart';
import 'package:mate_op/provider/mateop_state.dart';

void updateFileWithVectorPerformace(MateOpState state) {
  ExerciseManager exerciseManager = state.exerciseManager;
  MOUser user = state.user;
  PerformanceVectors performanceVectors =
      PerformanceVectors.readObjectFromFile(state.localPath, state.operation);
  performanceVectors.updatePerformanceVectorsSet(exerciseManager.allExercises,
      user.grade, user.getSession(state.operation));
  performanceVectors.writeObjectInFile(state.localPath, state.operation);
  try {
    print(performanceVectors.toJson().runtimeType);
    updatePerformanceData(
        user, state.operation, performanceVectors.toFirebaseJson());
    // clearSessionFile(user);
    deleteSessionFile(state.localPath, state.operation, state.userId);
    updateAverageTimes(exerciseManager, user, state.operation);
    List results = exerciseManager.getResults();
    user.updateWinRate(results[3]);
    user.score += results[4];
    user.stars += results[2];
    user.registries = performanceVectors.userRecord();
    updateUserMetadata(user);
  } catch (e) {
    print(e.toString());
  }
}

void updateAverageTimes(ExerciseManager exerciseManager, MOUser user,
    OperationType operation) async {
  Map times = await getAverageTimes(user.schoolType);
  String grade = user.grade.toString();
  for (var i = 0; i < 5; i++) {
    int index = operation == OperationType.addition ? i : i + 9;
    int number = times['metadata'][index][grade];
    double time = times['data'][index][grade].toDouble();
    double uTime = exerciseManager.getAverageTimePerLO(index);
    if (!uTime.isNaN) {
      time = (time * (number / (number + 1))) + (uTime / (number + 1));
      times['metadata'][index][grade] = number + 1;
      times['data'][index][grade] = time;
    }
  }
  await setAverageTimes(times, user.schoolType);
}

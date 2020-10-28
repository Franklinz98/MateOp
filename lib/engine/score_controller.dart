import 'package:mate_op/backend/firebase/data.dart';
import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/performance_vectors.dart';
import 'package:mate_op/models/user.dart';

void updateFileWithVectorPerformace(
    ExerciseManager exerciseManager, MOUser user) async {
  PerformanceVectors performanceVectors =
      PerformanceVectors.readObjectFromFile(await localPath);
  performanceVectors.updatePerformanceVectorsSet(
      exerciseManager.allExercises, user.grade, user.session);
  performanceVectors.writeObjectInFile(await localPath);
  await updatePerformanceData(user, performanceVectors.toJson);
  await deleteSessionFile(user);
  updateAverageTimes(exerciseManager, user);
}

void updateAverageTimes(ExerciseManager exerciseManager, MOUser user) async {
  Map times = await getAverageTimes(user.schoolType);
  String grade = user.grade.toString();
  for (var i = 0; i < 5; i++) {
    int number = times['metadata'][i][grade];
    double time = times['data'][i][grade].toDouble();
    double uTime = exerciseManager.getAverageTimePerLO(i);
    if (!uTime.isNaN) {
      time = (time * (number / (number + 1))) + (uTime / (number + 1));
      times['metadata'][i][grade] = number + 1;
      times['data'][i][grade] = time;
    }
  }
  await setAverageTimes(times, user.schoolType);
}

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
}

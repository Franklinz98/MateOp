import 'dart:convert';
import 'dart:io';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

File getLocalFile(String path, String filename) {
  return File('$path/$filename.json');
}

void writeSessionFile(String path, ExerciseManager exerciseManager,
    OperationType operation, String uid) {
  String filename =
      "session_file_${p.extension(operation.toString()).replaceAll('.', '')}_$uid";
  if (exerciseManager.currentExercise < 14) {
    File file = getLocalFile(path, filename);
    file.writeAsStringSync(json.encode(exerciseManager.toJson()),
        mode: FileMode.write);
  }
}

ExerciseManager readSessionFile(
    String path, OperationType operation, String uid) {
  String filename =
      "session_file_${p.extension(operation.toString()).replaceAll('.', '')}_$uid";
  File file = getLocalFile(path, filename);
  String content = file.readAsStringSync();
  return ExerciseManager.fromJson(json.decode(content));
}

void deleteSessionFile(String path, OperationType operation, String uid) {
  String filename =
      "session_file_${p.extension(operation.toString()).replaceAll('.', '')}_$uid";
  File file = getLocalFile(path, filename);
  print(file.existsSync());
  file.deleteSync();
  print(file.existsSync());
}

// Write user performance json

// Read user performance json

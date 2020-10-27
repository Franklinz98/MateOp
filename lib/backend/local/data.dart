import 'dart:convert';
import 'dart:io';

import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/user.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

File getLocalFile(String path, String filename) {
  return File('$path/$filename.json');
}

Future<void> writeSessionFile(
    ExerciseManager exerciseManager, MOUser user) async {
  String path = await localPath;
  String filename = "session_file_${user.firebaseUser.uid}";
  File file = getLocalFile(path, filename);
  file.writeAsStringSync(json.encode(exerciseManager.toJson()),
      mode: FileMode.write);
}

Future<ExerciseManager> readSessionFile(MOUser user) async {
  String path = await localPath;
  String filename = "session_file_${user.firebaseUser.uid}";
  File file = getLocalFile(path, filename);
  return ExerciseManager.fromJson(json.decode(file.readAsStringSync()));
}

Future<void> deleteSessionFile(MOUser user) async {
  String path = await localPath;
  String filename = "session_file_${user.firebaseUser.uid}";
  File file = getLocalFile(path, filename);
  file.deleteSync();
}

// Write user performance json

// Read user performance json

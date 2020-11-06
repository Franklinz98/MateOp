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

void writeSessionFile(
    String path, ExerciseManager exerciseManager, String uid) {
  String filename = "session_file_$uid";
  File file = getLocalFile(path, filename);
  file.writeAsStringSync(json.encode(exerciseManager.toJson()),
      mode: FileMode.write);
}

ExerciseManager readSessionFile(String path, String uid) {
  String filename = "session_file_$uid";
  File file = getLocalFile(path, filename);
  String content = file.readAsStringSync();
  return ExerciseManager.fromJson(json.decode(content));
}

void deleteSessionFile(String path, String uid) {
  String filename = "session_file_$uid";
  File file = getLocalFile(path, filename);
  file.deleteSync();
}

// Write user performance json

// Read user performance json

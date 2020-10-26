import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

File getLocalFile(String path, String filename) {
  return File('$path/$filename.json');
}

// Write session file method
Future<File> writeSessionFile(){
  
}

// Read session file method

// Write user performance json

// Read user performance json

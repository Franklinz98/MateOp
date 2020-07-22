import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mate_op/app/app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
  runApp(GameApp());
}

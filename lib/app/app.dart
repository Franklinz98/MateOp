import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mate_op/screens/containers/playground.dart';

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      title: 'Mate Op',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: PlayGround(),
    );
  }
}

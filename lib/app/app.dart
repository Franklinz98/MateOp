import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mate_op/provider/mateop_state.dart';
import 'package:mate_op/screens/routes/authentication.dart';
import 'package:mate_op/screens/routes/main_container.dart';
import 'package:provider/provider.dart';

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
      home: ChangeNotifierProvider<MateOpState>(
        create: (context) => MateOpState(),
        child: MainContainer(),
      ),
    );
  }
}

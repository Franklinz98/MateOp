import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/provider/mateop_state.dart';
import 'package:mate_op/screens/views/home.dart';
import 'package:mate_op/screens/views/results.dart';
import 'package:provider/provider.dart';

class MainContainer extends StatefulWidget {
  @override
  MainContainerState createState() => MainContainerState();
}

class MainContainerState extends State<MainContainer> {
  Widget _content;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    initPath();
    _content = Home(
      state: Provider.of<MateOpState>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/background_a.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          _content,
        ],
      ),
    );
  }

  void initPath() async {
    Provider.of<MateOpState>(context, listen: false)
        .updatePath(await localPath);
  }
}

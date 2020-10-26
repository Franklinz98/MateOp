import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mate_op/screens/views/home.dart';
import 'package:mate_op/screens/views/login.dart';

class MainContainer extends StatefulWidget {
  @override
  MainContainerState createState() => MainContainerState();
}

class MainContainerState extends State<MainContainer> {
  Widget _content = Home();

@override
  void initState() {
    super.initState();
    Firebase.initializeApp();
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
}

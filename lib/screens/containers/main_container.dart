import 'package:flutter/material.dart';
import 'package:mate_op/screens/views/home.dart';

class MainContainer extends StatefulWidget {
  @override
  MainContainerState createState() => MainContainerState();
}

class MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/background.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Home(),
        ],
      ),
    );
  }
}
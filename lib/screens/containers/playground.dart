import 'package:flutter/material.dart';
import 'package:mate_op/screens/views/game_zone.dart';

class PlayGround extends StatefulWidget {
  @override
  _PlayGroundState createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/background_b.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          GameZone(),
        ],
      ),
    );
  }
}

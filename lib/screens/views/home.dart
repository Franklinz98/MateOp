import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/animations/astronaut/astronaut.dart';
import 'package:mate_op/animations/rockets/rocket_a.dart';
import 'package:mate_op/constants/enums.dart';

class Home extends StatelessWidget {
  final String imagesUri = "assets/images";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          RocketAAnim(
              screenSize: screenSize,
              duration: Duration(seconds: 2),
              size: Size(50, 162),
              margin: Size(90, 55),
              angle: 42,
              positionOffset: Size(-8, 8),
              alignment: AnimAlignment.topLeft),
          AstronautAnim(
            screenSize: screenSize,
            size: Size(212.0, 150.0),
            margin: Size(10, 10),
            angle: -31.0,
            positionOffset: Size(2, 7),
            alignment: AnimAlignment.centerRight,
            duration: Duration(seconds: 3),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Hola User!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: Colors.white),
                ),
                GestureDetector(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image.asset("$imagesUri/moon_asset.png"),
                      Image.asset("$imagesUri/play_icon.png"),
                    ],
                  ),
                ),
                Text(
                  "Juguemos...",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(fontSize: 28, color: Colors.white),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 24.0),
              child: Image.asset("$imagesUri/cup_icon.png"),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 24.0),
              child: Image.asset("$imagesUri/cog_icon.png"),
            ),
          ),
        ],
      ),
    );
  }
}

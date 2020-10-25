import 'dart:math';

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
          Positioned(
            left: 90,
            top: 55,
            child: Transform.rotate(
              angle: 42 * pi / 180.0,
              child: Image.asset(
                "assets/images/rocket_asset.png",
                height: 162,
                width: 50,
              ),
            ),
          ),
          Positioned(
            right: 55,
            top: 90,
            child: Transform.rotate(
              angle: 31 * pi / 180.0,
              child: Image.asset(
                "assets/images/astronaut_asset.png",
                height: 150,
                width: 212,
              ),
            ),
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

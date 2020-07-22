import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/animations/astronaut.dart';
import 'package:mate_op/animations/rocket.dart';

class Home extends StatelessWidget {
  final String images_uri = "assets/images";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Stack(
        children: <Widget>[
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
                      Image.asset("$images_uri/moon_asset.png"),
                      Image.asset("$images_uri/play_icon.png"),
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
              child: Image.asset("$images_uri/cup_icon.png"),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 24.0),
              child: Image.asset("$images_uri/cog_icon.png"),
            ),
          ),
          AstronautAnim(),
          RocketAnim(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/animations/astronaut/astronaut.dart';
import 'package:mate_op/animations/planets/blue_shades.dart';
import 'package:mate_op/animations/planets/orange.dart';
import 'package:mate_op/animations/planets/pink.dart';
import 'package:mate_op/animations/rockets/rocket_a.dart';
import 'package:mate_op/components/moon.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SessionResults extends StatelessWidget {
  final stars = 2;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          RocketAAnim(
            screenSize: screenSize,
            size: Size(58.5, 190.5),
            margin: Size(42.0, 0),
            angle: 28,
            positionOffset: Size(-3, 12),
            alignment: AnimAlignment.centerLeft,
            duration: Duration(seconds: 2),
          ),
          AstronautAnim(
            screenSize: screenSize,
            size: Size(245, 124.6),
            margin: Size(-80.0, 50),
            angle: -31,
            positionOffset: Size(5, 8),
            alignment: AnimAlignment.centerRight,
            duration: Duration(seconds: 3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MoonPlanet(
                      size: Size(
                        100.0,
                        100.0,
                      ),
                      child: Image.asset(
                        stars >= 2
                            ? "assets/images/star.png"
                            : "assets/images/star_placeholder.png",
                      ),
                    ),
                    MoonPlanet(
                      size: Size(
                        100.0,
                        100.0,
                      ),
                      child: Image.asset(
                        stars >= 1
                            ? "assets/images/star.png"
                            : "assets/images/star_placeholder.png",
                      ),
                    ),
                    MoonPlanet(
                      size: Size(
                        100.0,
                        100.0,
                      ),
                      child: Image.asset(
                        stars == 3
                            ? "assets/images/star.png"
                            : "assets/images/star_placeholder.png",
                      ),
                    ),
                  ],
                ),
                Text(
                  "12 preguntas correctas de 15",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Text(
                            "Puntaje",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "80",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Text(
                            "Tiempo",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "01:08",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset("assets/images/results_button.png"),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/animations/planets/blue_shades.dart';
import 'package:mate_op/components/moon.dart';
import 'package:mate_op/animations/planets/orange.dart';
import 'package:mate_op/animations/planets/pink.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GameZone extends StatefulWidget {
  @override
  _GameZoneState createState() => _GameZoneState();
}

class _GameZoneState extends State<GameZone> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          BlueShadesPlanetAnim(
            screenSize: screenSize,
            size: Size(130, 130),
            margin: Size(80, -35),
            angle: 0,
            positionOffset: Size(0, 5),
            alignment: AnimAlignment.centerLeft,
            duration: Duration(seconds: 2),
            type: AnimType.parent,
            child: Text(
              "10",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 38,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.54),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          PinkPlanetAnim(
            screenSize: screenSize,
            size: Size(130, 130),
            margin: Size(0, -35),
            angle: 0,
            positionOffset: Size(0, -5),
            alignment: AnimAlignment.center,
            duration: Duration(seconds: 2),
            type: AnimType.parent,
            child: Text(
              "9",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 38,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.54),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          OrangePlanetAnim(
            screenSize: screenSize,
            size: Size(130, 130),
            margin: Size(80, -35),
            angle: 0,
            positionOffset: Size(0, 5),
            alignment: AnimAlignment.centerRight,
            duration: Duration(seconds: 2),
            type: AnimType.parent,
            child: Text(
              "?",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 38,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.54),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                LinearPercentIndicator(
                  backgroundColor: Colors.white.withOpacity(0.50),
                  progressColor: Colors.white,
                  percent: 0.8,
                  lineHeight: 6.0,
                ),
                SizedBox(
                  height: 24.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "+",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "=",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MoonPlanet(
                      size: Size(
                        75.0,
                        75.0,
                      ),
                      child: Text(
                        "9",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          color: Color(0xff001e7e),
                          shadows: [
                            Shadow(
                              offset: Offset(0.00, 3.00),
                              color: Color(0xff000000).withOpacity(0.54),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    MoonPlanet(
                      size: Size(
                        75.0,
                        75.0,
                      ),
                      child: Text(
                        "19",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          color: Color(0xff001e7e),
                          shadows: [
                            Shadow(
                              offset: Offset(0.00, 3.00),
                              color: Color(0xff000000).withOpacity(0.54),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    MoonPlanet(
                      size: Size(
                        75.0,
                        75.0,
                      ),
                      child: Text(
                        "12",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          color: Color(0xff001e7e),
                          shadows: [
                            Shadow(
                              offset: Offset(0.00, 3.00),
                              color: Color(0xff000000).withOpacity(0.54),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    MoonPlanet(
                      size: Size(
                        75.0,
                        75.0,
                      ),
                      child: Text(
                        "X",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                          color: Color(0xff001e7e),
                          shadows: [
                            Shadow(
                              offset: Offset(0.00, 3.00),
                              color: Color(0xff000000).withOpacity(0.54),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ), */
                SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

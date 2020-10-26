import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/animations/astronaut/astronaut.dart';
import 'package:mate_op/animations/rockets/rocket_a.dart';
import 'package:mate_op/constants/colors.dart';
import 'package:mate_op/constants/enums.dart';

class Login extends StatelessWidget {
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
              margin: Size(32, 55),
              angle: -35,
              positionOffset: Size(8, 8),
              alignment: AnimAlignment.topRight),
          AstronautAnim(
            screenSize: screenSize,
            size: Size(212.0, 150.0),
            margin: Size(15, 0),
            angle: 33.0,
            positionOffset: Size(-2, 7),
            alignment: AnimAlignment.bottomLeft,
            duration: Duration(seconds: 3),
          ),
          Center(
            child: Container(
              height: 300.00,
              width: 374.00,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(17.00),
              ),
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Inicia",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: GameColors.meteorite,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 65.0,
                        child: Text(
                          "Correo",
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: GameColors.vivid_violet,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 38.00,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.00),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 65.0,
                        child: Text(
                          "Clave",
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: GameColors.vivid_violet,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 38.00,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.00),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        child: Image.asset("$imagesUri/login_button.png"),
                        onTap: () {},
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      "¿Olvidaste tu contraseña?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        color: GameColors.vivid_violet,
                      ),
                    ),
                  )
                ],
              ),
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

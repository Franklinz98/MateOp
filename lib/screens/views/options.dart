import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/animations/astronaut/astronaut.dart';
import 'package:mate_op/animations/planets/blue_shades.dart';
import 'package:mate_op/animations/planets/orange.dart';
import 'package:mate_op/animations/planets/pink.dart';
import 'package:mate_op/animations/rockets/rocket_a.dart';
import 'package:mate_op/backend/service/service.dart';
import 'package:mate_op/components/moon.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/provider/mateop_state.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class OperationOptions extends StatelessWidget {
  final String imagesUri = "assets/images";
  final MateOpState state;

  const OperationOptions({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Provider.of<MateOpState>(context, listen: false)
            .setMainScreenLoud(MainScreen.home);
        return false;
      },
      child: SafeArea(
        child: Stack(
          children: [
            RocketAAnim(
              screenSize: screenSize,
              size: Size(58.5, 190.5),
              margin: Size(22.0, 0),
              angle: 28,
              positionOffset: Size(-3, 12),
              alignment: AnimAlignment.centerLeft,
              duration: Duration(seconds: 2),
            ),
            AstronautAnim(
              screenSize: screenSize,
              size: Size(245, 124.6),
              margin: Size(16.0, 98),
              angle: -31,
              positionOffset: Size(5, 8),
              alignment: AnimAlignment.centerRight,
              duration: Duration(seconds: 3),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.asset("$imagesUri/moon_asset.png"),
                            Text(
                              'Suma',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w600,
                                fontSize: 32,
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
                          ],
                        ),
                        onTap: () {
                          state.setOperation(OperationType.addition);
                          state.setMainScreenLoud(MainScreen.loading);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.asset("$imagesUri/moon_asset.png"),
                            Text(
                              'Resta',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w600,
                                fontSize: 32,
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
                          ],
                        ),
                        onTap: () {
                          state.setOperation(OperationType.subtraction);
                          state.setMainScreenLoud(MainScreen.loading);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

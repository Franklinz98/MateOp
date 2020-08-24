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

class MateOpRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Puntuación",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.white,
                    ),
                    child: DataTable(
                      sortAscending: true,
                      sortColumnIndex: 0,
                      columnSpacing: 8,
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Puesto',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Nombre',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Estrellas',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Nivel',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Grado',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Center(
                                child: Text(
                                  '1',
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(Text(
                              'Sarah',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )),
                            DataCell(Center(
                              child: Text(
                                '5',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            DataCell(Center(
                              child: Text(
                                '2',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            DataCell(Center(
                              child: Text(
                                '4',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Center(
                              child: Text(
                                '2',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            DataCell(Text(
                              'Janine',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )),
                            DataCell(Center(
                              child: Text(
                                '4',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            DataCell(Center(
                              child: Text(
                                '2',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            DataCell(Center(
                              child: Text(
                                '4',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/images/ranking_prev.png"),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "1",
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/images/ranking_next.png"),
                    ),
                  ],
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

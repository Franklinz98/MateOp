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

class MateOpRanking extends StatelessWidget {
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
              margin: Size(-140.0, 50),
              angle: -31,
              positionOffset: Size(5, 8),
              alignment: AnimAlignment.centerRight,
              duration: Duration(seconds: 3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
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
                        child: getScoreboard(context)),
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
      ),
    );
  }

  FutureBuilder getScoreboard(BuildContext context) {
    return FutureBuilder<List>(
      future: getLeaderboard(Provider.of<MateOpState>(context, listen: false)
          .user
          .score
          .toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: DataTable(
                  sortAscending: true,
                  sortColumnIndex: 0,
                  columnSpacing: 20,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Puesto',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Nombre',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Grado',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Nivel',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Estrellas',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'V/D',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Puntaje',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                  rows: getRows(snapshot.data)),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  List<DataRow> getRows(List data) {
    List<DataRow> rows = List();
    for (var row in data) {
      rows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Center(
                child: Text(
                  row['pos'].toString(),
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            DataCell(Text(
              row['name'],
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                color: Colors.white,
              ),
            )),
            DataCell(Center(
              child: Text(
                row['grade'].toString(),
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )),
            DataCell(Center(
              child: Text(
                row['level'].toString(),
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )),
            DataCell(Center(
              child: Text(
                row['stars'].toString(),
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )),
            DataCell(Center(
              child: Text(
                '${row['winRate']}%',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )),
            DataCell(Center(
              child: Text(
                row['score'].toString(),
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )),
          ],
        ),
      );
    }
    return rows;
  }
}

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/backend/firebase/authentication.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/models/user.dart';
import 'package:mate_op/provider/mateop_state.dart';
import 'package:mate_op/screens/routes/authentication.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  final String imagesUri = "assets/images";
  final MateOpState state;

  const Home({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MateOpState _provider = Provider.of<MateOpState>(context, listen: false);
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
                  this.state.user != null
                      ? "Hola ${this.state.user.firebaseUser.displayName}!"
                      : "Hola!",
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
                  onTap: () async {
                    User firebaseUser = currentUser();
                    if (firebaseUser == null) {
                      MOUser user;
                      user = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authentication()),
                      );
                      state.setUser(user);
                    }
                    state.setMainScreenLoud(MainScreen.options);
                  },
                ),
                Text(
                  "Juguemos...",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(fontSize: 28, color: Colors.white),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _provider.user != null,
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 24.0),
                  child: Image.asset("$imagesUri/cup_icon.png"),
                ),
                onTap: () {
                  this.state.setMainScreenLoud(MainScreen.ranking);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 24.0),
                child: Image.asset("$imagesUri/cog_icon.png"),
              ),
              onTap: () {
                this.state.setMainScreenLoud(MainScreen.about);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0, left: 24.0),
                child: GestureDetector(
                  child: Text(
                    "Graphics by Freepik.com",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    if (await canLaunch('https://Freepik.com')) {
                      await launch('https://Freepik.com');
                    } else {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Visita Freepik.com!')));
                    }
                  },
                ),
              ),
              onTap: () {
                this.state.setMainScreenLoud(MainScreen.about);
              },
            ),
          ),
        ],
      ),
    );
  }
}

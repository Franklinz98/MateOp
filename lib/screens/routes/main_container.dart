import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mate_op/backend/firebase/authentication.dart';
import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/models/user.dart';
import 'package:mate_op/provider/mateop_state.dart';
import 'package:mate_op/screens/routes/playground.dart';
import 'package:mate_op/screens/views/home.dart';
import 'package:mate_op/screens/views/loading.dart';
import 'package:mate_op/screens/views/ranking.dart';
import 'package:mate_op/screens/views/results.dart';
import 'package:provider/provider.dart';

class MainContainer extends StatefulWidget {
  @override
  MainContainerState createState() => MainContainerState();
}

class MainContainerState extends State<MainContainer> {
  MateOpState _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<MateOpState>(context, listen: false);
    Firebase.initializeApp().then((value) async {
      MOUser user;
      User firebaseUser = currentUser();
      if (firebaseUser != null) {
        user = await getUserObject(firebaseUser);
        _provider.setUser(user);
      } else {
        _provider.setUser(null);
      }
    });
    initPath();
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<MateOpState>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/background_a.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          screen(),
        ],
      ),
    );
  }

  /* void openGameZone(BuildContext context, MateOpState state) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<MateOpState>.value(
          value: state,
          child: PlayGround(),
        ),
      ),
    );
  } */

  void initPath() async {
    Provider.of<MateOpState>(context, listen: false)
        .updatePath(await localPath);
  }

  Widget screen() {
    switch (Provider.of<MateOpState>(context).mainScreen) {
      case MainScreen.home:
        return Home(state: _provider);
        break;
      case MainScreen.ranking:
        return MateOpRanking();
        break;
      case MainScreen.about:
        break;
      /* default:
        return LoadingScreen(
          state: _provider,
          openPlayground: () {
            _provider.setMainScreenLoud(MainScreen.home);
            openGameZone(context, _provider);
          },
        ); */
    }
  }
}

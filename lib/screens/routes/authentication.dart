import 'package:flutter/material.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/screens/views/login.dart';
import 'package:mate_op/screens/views/recover_pass.dart';

class Authentication extends StatefulWidget {
  @override
  _WidgetRoute createState() => _WidgetRoute();
}

class _WidgetRoute extends State<Authentication> {
  Widget _content;
  AuthScreen _screen = AuthScreen.login;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _updateScreen();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/background_a.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: _content,
          ),
        ],
      ),
    );
  }

  _updateScreen() {
    switch (_screen) {
      case AuthScreen.login:
        _content = Login(
          screenSwitch: () {
            setState(() {
              _screen = AuthScreen.recover;
            });
          },
        );
        break;
      case AuthScreen.recover:
        _content = RecoverPassword(
          screenSwitch: () {
            setState(() {
              _screen = AuthScreen.login;
            });
          },
        );
        break;
    }
  }
}

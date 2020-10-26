import 'package:flutter/material.dart';
import 'package:mate_op/screens/views/login.dart';
import 'package:mate_op/screens/views/recover_pass.dart';

class Authentication extends StatefulWidget {
  @override
  _WidgetRoute createState() => _WidgetRoute();
}

class _WidgetRoute extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/background_a.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          RecoverPassword(),
        ],
      ),
    );
  }
}

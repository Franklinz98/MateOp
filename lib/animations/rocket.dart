import 'package:flutter/material.dart';

class RocketAnim extends StatefulWidget {
  @override
  _RocketAnimState createState() => _RocketAnimState();
}

class _RocketAnimState extends State<RocketAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this)
          ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromLTRB(
            -10, size.height / 2 - 79, size.width - 70, size.height / 2 - 88),
        end: RelativeRect.fromLTRB(
            0, size.height / 2 - 88, size.width - 80, size.height / 2 - 79),
      ).animate(_animationController),
      child: Image.asset(
        "assets/images/rocket_asset.png",
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

class AstronautAnim extends StatefulWidget {
  @override
  _AstronautAnimState createState() => _AstronautAnimState();
}

class _AstronautAnimState extends State<AstronautAnim>
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
            size.width - 225, size.height / 2 - 113, 0, size.height / 2 - 93),
        end: RelativeRect.fromLTRB(
            size.width - 220, size.height / 2 - 93, 0, size.height / 2 - 113),
      ).animate(_animationController),
      child: Image.asset(
        "assets/images/astronaut_asset.png",
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:mate_op/animations/planets/planet.dart';
import 'package:mate_op/constants/enums.dart';

class MoonPlanet extends StatelessWidget {
  final Size size;
  final Widget child;
  final GestureTapCallback onTap;

  MoonPlanet({
    Key key,
    @required this.size,
    @required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/moon_asset.png",
            height: size.height,
            width: size.width,
          ),
          child
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mate_op/animations/animation.dart';
import 'package:mate_op/constants/enums.dart';

class AstronautAnim extends StatelessWidget {
  final Size screenSize;
  final Size size;
  final Size margin;
  final double angle;
  final Size positionOffset;
  final AnimAlignment alignment;
  final Duration duration;

  AstronautAnim({
    Key key,
    @required this.screenSize,
    @required this.size,
    @required this.margin,
    @required this.angle,
    @required this.positionOffset,
    @required this.alignment,
    @required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MateOpAnim(
      child: Image.asset(
        "assets/images/astronaut_asset.png",
        height: size.height,
        width: size.width,
      ),
      childSize: size,
      screenSize: screenSize,
      margin: margin,
      angle: angle,
      positionOffset: positionOffset,
      alignment: alignment,
      duration: duration,
    );
  }
}

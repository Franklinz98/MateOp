import 'package:flutter/material.dart';
import 'package:mate_op/animations/planets/planet.dart';
import 'package:mate_op/constants/enums.dart';

class PinkPlanetAnim extends PlanetAnim {
  final Size screenSize;
  final Size size;
  final Size margin;
  final double angle;
  final Size positionOffset;
  final AnimAlignment alignment;
  final Duration duration;
  final Widget child;
  final AnimType type;

  PinkPlanetAnim(
      {Key key,
      @required this.screenSize,
      @required this.size,
      @required this.margin,
      @required this.angle,
      @required this.positionOffset,
      @required this.alignment,
      @required this.duration,
      @required this.type,
      this.child})
      : super(
          uri: "assets/images/pink_planet.png",
          screenSize: screenSize,
          size: size,
          margin: margin,
          angle: angle,
          positionOffset: positionOffset,
          alignment: alignment,
          duration: duration,
          type: type,
          child: child,
        );
}

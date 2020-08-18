import 'package:flutter/material.dart';
import 'package:mate_op/animations/animation.dart';
import 'package:mate_op/constants/enums.dart';

class PlanetAnim extends StatelessWidget {
  final Size screenSize;
  final Size size;
  final Size margin;
  final double angle;
  final Size positionOffset;
  final AnimAlignment alignment;
  final Duration duration;
  final Widget child;
  final AnimType type;
  final String uri;

  PlanetAnim(
      {Key key,
      @required this.uri,
      @required this.screenSize,
      @required this.size,
      @required this.margin,
      @required this.angle,
      @required this.positionOffset,
      @required this.alignment,
      @required this.duration,
      @required this.type,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = Image.asset(
      uri,
      height: size.height,
      width: size.width,
    );

    return MateOpAnim(
      child: this.type == AnimType.standalone
          ? image
          : Stack(
              alignment: Alignment.center,
              children: [image, child],
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

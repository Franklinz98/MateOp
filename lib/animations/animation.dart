import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mate_op/constants/enums.dart';

class MateOpAnim extends StatefulWidget {
  final Widget child;
  final Size childSize;
  final Size screenSize;
  final Size margin;
  final double angle;
  final Size positionOffset;
  final AnimAlignment alignment;
  final Duration duration;

  const MateOpAnim({
    Key key,
    @required this.child,
    @required this.childSize,
    @required this.screenSize,
    @required this.margin,
    @required this.angle,
    @required this.positionOffset,
    @required this.alignment,
    @required this.duration,
  }) : super(key: key);

  @override
  _MateOpAnim createState() => _MateOpAnim();
}

class _MateOpAnim extends State<MateOpAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _radians;
  RelativeRect _begin;
  RelativeRect _end;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: widget.duration, vsync: this)
          ..repeat(reverse: true);
    _radians = widget.angle * pi / 180.0;
    _initRecs();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: RelativeRectTween(
        begin: _begin,
        end: _end,
      ).animate(_animationController),
      child: Transform.rotate(
        angle: _radians,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _initRecs() {
    List<double> horizontalMargins = [
      widget.screenSize.width - widget.margin.width - widget.childSize.width,
      widget.margin.width,
      widget.screenSize.width / 2 - widget.childSize.width / 2,
    ];
    List<double> verticalMargins = [
      widget.screenSize.height - widget.margin.height - widget.childSize.height,
      widget.margin.height,
      widget.screenSize.height / 2 - widget.childSize.height / 2,
    ];
    double top;
    double bottom;
    double left;
    double right;
    switch (widget.alignment) {
      case AnimAlignment.topLeft:
        top = verticalMargins[1];
        bottom = verticalMargins[0];
        left = horizontalMargins[1];
        right = horizontalMargins[0];
        break;
      case AnimAlignment.topCenter:
        top = verticalMargins[1];
        bottom = verticalMargins[0];
        right = horizontalMargins[2];
        left = horizontalMargins[2];
        break;
      case AnimAlignment.topRight:
        top = verticalMargins[1];
        bottom = verticalMargins[0];
        right = horizontalMargins[1];
        left = horizontalMargins[0];
        break;
      case AnimAlignment.centerLeft:
        bottom = verticalMargins[2];
        top = verticalMargins[2];
        left = horizontalMargins[1];
        right = horizontalMargins[0];
        break;
      case AnimAlignment.centerRight:
        top = verticalMargins[2];
        bottom = verticalMargins[2];
        right = horizontalMargins[1];
        left = horizontalMargins[0];
        break;
      case AnimAlignment.bottomLeft:
        bottom = verticalMargins[1];
        top = verticalMargins[0];
        left = horizontalMargins[1];
        right = horizontalMargins[0];
        break;
      case AnimAlignment.bottomCenter:
        bottom = verticalMargins[1];
        top = verticalMargins[0];
        right = horizontalMargins[2];
        left = horizontalMargins[2];
        break;
      case AnimAlignment.bottomRight:
        bottom = verticalMargins[1];
        top = verticalMargins[0];
        right = horizontalMargins[1];
        left = horizontalMargins[0];
        break;
    }
    _begin = RelativeRect.fromLTRB(left + widget.positionOffset.width,
        top + widget.positionOffset.height, right, bottom);
    _end = RelativeRect.fromLTRB(left, top, right + widget.positionOffset.width,
        bottom + widget.positionOffset.height);
  }
}

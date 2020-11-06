import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TimerBar extends StatefulWidget {
  final Function durationUpdate;
  final tick = Duration(milliseconds: 250);
  final _TimerState state = _TimerState();

  TimerBar({Key key, @required this.durationUpdate}) : super(key: key);

  @override
  _TimerState createState() => state;

  void stopTicker() {
    this.state._timer.cancel();
  }

  void startTicker() {
    this.state.ticker();
  }
}

class _TimerState extends State<TimerBar> {
  double _progress;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _progress = 0;
    ticker();
  }

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      backgroundColor: Colors.white.withOpacity(0.50),
      progressColor: Colors.white,
      percent: _progress,
      lineHeight: 6.0,
    );
  }

  void ticker() async {
    _timer = Timer.periodic(widget.tick, (time) {
      setState(() {
        widget.durationUpdate.call(widget.tick);
        _progress = (time.tick / 240);
      });
      if (time.tick == 240) {
        time.cancel();
      }
    });
  }

  @override
  void dispose() {
    try {
      _timer.cancel();
    } catch (e) {}
    super.dispose();
  }
}

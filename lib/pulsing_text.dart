import 'package:flutter/material.dart';

class PulsingText extends StatefulWidget {
  @override
  _PulsingTextState createState() => _PulsingTextState();
}

class _PulsingTextState extends State<PulsingText>
    with SingleTickerProviderStateMixin {
  AnimationController textAnimationController;
  Animation<double> textAnimation;
  double fontSize = 24;
  @override
  initState() {
    super.initState();

    textAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    )
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          textAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          textAnimationController.forward();
        }
      });
    textAnimation = Tween(begin: 30.0, end: 27.0).animate(
      CurvedAnimation(
        parent: textAnimationController,
        curve: Curves.easeInBack,
        reverseCurve: Curves.easeOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 200,
      child: Center(
        child: AnimatedBuilder(
          animation: textAnimationController,
          builder: (context, child) {
            return Text(
              '1. Select Class',
              style: TextStyle(fontSize: textAnimation.value),
            );
          },
        ),
      ),
    );
  }
}

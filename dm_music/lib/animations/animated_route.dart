import 'package:flutter/material.dart';

class AnimatedRoute {
  static Route createRoute(
      {StatefulWidget scene, Curve curves, Offset offset, int durationMilli}) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: durationMilli),
      pageBuilder: (context, animation, secondaryAnimation) => scene,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: Offset(1.0, 0.0),
              end: offset,
            ).chain(
              CurveTween(
                curve: curves,
              ),
            ),
          ),
          child: child,
        );
      },
    );
  }
}
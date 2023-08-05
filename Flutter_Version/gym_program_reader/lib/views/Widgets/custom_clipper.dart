import 'dart:math';
import 'package:flutter/material.dart';

class TimerCustomClipper extends CustomClipper<Path> {
  TimerCustomClipper({required this.clipAmount});
  double clipAmount = 0;
  @override
  getClip(Size size) {
    /// calculations for getting the coordinates of a point in a circular motion,
    /// around a given center, and distant from the center by the radius
    /// -- math instructions:
    /// x = R*cos(t) + center.x;
    /// y = R*sin(t) + center.y;
    /// -- custom parameters application:
    /// t = clipAmount + pi
    /// the addition of (pi / 2) is for starting quadrant
    /// the minus sign on the "sin(...)" is for counterclockwise rotation

    assert(clipAmount >= 0 && clipAmount <= 1.0);

    double x = (size.width / 2) * 1.01 * cos((pi / 2) + (2 * clipAmount) * pi) +
        size.width / 2;
    double y =
        (size.width / 2) * 1.01 * -sin((pi / 2) + (2 * clipAmount) * pi) +
            size.width / 2;

    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(x, y);
    if (clipAmount < 0.25) {
      path.lineTo(0, 0);
    } else if (clipAmount >= 0.25 && clipAmount < 0.5) {
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    } else if (clipAmount >= 0.5 && clipAmount < 0.75) {
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    } else if (clipAmount >= 0.75 && clipAmount < 1.0) {
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

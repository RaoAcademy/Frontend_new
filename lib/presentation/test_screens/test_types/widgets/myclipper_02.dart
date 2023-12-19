import 'dart:math';

import 'package:flutter/material.dart';

class MyClipper02 extends CustomClipper<Path> {
  MyClipper02({
    num? borderRadius,
    num? angle,
  })  : _borderRadius = borderRadius?.toDouble() ?? .1,
        _angle = angle?.toDouble() ?? degToRad(80).toDouble();
  final double _borderRadius; // percentage of the shortest side
  final double _angle;
  @override
  Path getClip(Size size) {
    final borderRadius = _borderRadius * size.shortestSide;
    final dx = borderRadius * cos(_angle);
    final dy = borderRadius * sin(_angle);
    final dX = size.height / tan(_angle);
    final Path path = Path()
      ..moveTo(borderRadius, size.height)
      ..quadraticBezierTo(0, size.height, dx, size.height - dy)
      ..lineTo(dX - dx, dy)
      ..quadraticBezierTo(dX, 0, dX + borderRadius, 0)
      ..lineTo(size.width - borderRadius, 0)
      ..quadraticBezierTo(size.width, 0, size.width - dx, 0)
      ..lineTo(size.width, size.height - dy)
      ..quadraticBezierTo(size.width - dX, size.height,
          size.width - dX - borderRadius, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

num degToRad(num deg) => deg * (pi / 180.0);

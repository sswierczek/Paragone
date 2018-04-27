import 'package:flutter/material.dart';

class LoadingClipper extends CustomClipper<Path> {
  final double animation;
  final List<Offset> waveList;

  const LoadingClipper(this.animation, this.waveList);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addPolygon(waveList, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(LoadingClipper oldClipper) =>
      animation != oldClipper.animation;
}

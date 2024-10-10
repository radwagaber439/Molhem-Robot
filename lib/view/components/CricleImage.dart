import 'package:flutter/material.dart';
class CircularImageWidget extends StatelessWidget {
  final ImageProvider image;
  final double radius;

  const CircularImageWidget({
    Key? key,
    required this.image,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
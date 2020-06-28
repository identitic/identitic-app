import 'package:flutter/material.dart';

class IdentiticLogo extends StatelessWidget {
  const IdentiticLogo({
    this.width,
    this.height = 40,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image(
      width: width,
      height: height,
      image: AssetImage('assets/images/fingerprint.png'),
    );
  }
}

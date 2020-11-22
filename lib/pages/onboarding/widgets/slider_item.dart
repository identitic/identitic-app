import 'package:flutter/material.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({
    @required this.image,
    @required this.title,
    this.text,
  });

  final String image;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: <Widget>[
          SizedBox(height: 16),
          Image(
            height: 128,
            image: AssetImage(image),
          ),
          SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

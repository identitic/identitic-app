import 'package:flutter/material.dart';

class IdentiticButton extends StatelessWidget {
  const IdentiticButton({
    @required this.onPressed,
    this.color = Colors.pink,
    @required this.child,
  });

  final VoidCallback onPressed;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: color,
      textColor: Colors.white,
      shape: StadiumBorder(),
      padding: EdgeInsets.all(16),
      child: child,
    );
  }
}

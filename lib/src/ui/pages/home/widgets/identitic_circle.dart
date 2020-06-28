import 'package:flutter/material.dart';
import 'package:identitic/src/ui/widgets/theme.dart';

class IdentiticCircle extends StatelessWidget {
  const IdentiticCircle({
    Key key,
    this.onTap,
    this.child,
    this.text
  });

  final VoidCallback onTap;
  final Widget child;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width - 48) / 2,
        height: (MediaQuery.of(context).size.width - 48) / 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.pink,
            width: 4,
          ),
          color: Colors.white,
          boxShadow: identiticShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            child,
            SizedBox(height: 8),
            Text(text, style: TextStyle(fontSize: 16),), //TODO: decidir fontSize 16 o 18
          ],
        ),
      ),
    );
  }
}

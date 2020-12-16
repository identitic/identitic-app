import 'package:flutter/material.dart';

class IdentiticCircle extends StatelessWidget {
  const IdentiticCircle({Key key, this.onTap, this.child, this.text});

  final VoidCallback onTap;
  final Widget child;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: OutlineButton(
          onPressed: onTap,
          highlightedBorderColor: Colors.pink,
          borderSide: BorderSide(
            width: 2,
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

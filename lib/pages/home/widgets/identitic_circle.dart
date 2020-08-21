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
              ),
            ],
          ),
          // child: Container(
          //   width: (MediaQuery.of(context).size.width - 48) / 2,
          //   height: (MediaQuery.of(context).size.width - 48) / 2,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(
          //       color: Colors.pink,
          //       width: 2,
          //     ),
          //     color: Colors.white,
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       child,
          //       SizedBox(height: 8),
          //       Text(
          //         text,
          //         style: TextStyle(fontSize: 16),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}

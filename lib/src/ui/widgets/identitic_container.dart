import 'package:flutter/material.dart';

import 'package:identitic/src/ui/widgets/theme.dart';

class IdentiticContainer extends StatelessWidget {
  const IdentiticContainer({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: identiticShadow,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: child,
    );
  }
}

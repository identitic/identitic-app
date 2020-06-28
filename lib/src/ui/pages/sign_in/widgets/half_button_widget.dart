import 'package:flutter/material.dart';

import 'package:identitic/src/utils/constants.dart';

class HalfButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => Navigator.pushNamed(context, RouteName.sign_up),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(28),
        bottomRight: Radius.circular(28),
      )),
      color: Colors.deepPurpleAccent,
      padding: EdgeInsets.all(16),
      child: Text(
        'O registrate',
        style: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

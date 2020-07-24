import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('?'),
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¿Estás seguro que querés estar acá?\nAl parecer no hay nada',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Volver',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

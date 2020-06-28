import 'package:flutter/material.dart';
import 'package:identitic/src/ui/widgets/identitic_button.dart';

class DevelopingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('?', style: TextStyle(fontSize: 16),),
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Esta funcionalidad está en desarrollo.\n¡Seguimos trabajando para mejorar la educación!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            IdentiticButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Volver',
                style: TextStyle(color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

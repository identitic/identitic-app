import 'package:flutter/material.dart';

import 'package:identitic/pages/sign_up/widgets/sign_up_form_widget.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 8,
                  left: 16,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(64),
                      child: Image(
                        height: 100,
                        image: AssetImage('assets/images/fingerprint.png'),
                      ),
                    ),
                    SizedBox(height: 32),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                              text: 'Sé parte del ',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .color)),
                          TextSpan(
                            text: 'futuro ',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          TextSpan(
                              text: 'de la educación',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .color)),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: <Widget>[
                            SignUpFormWidget(),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
                      color: Colors.pink,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 64),
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
                          TextSpan(text: 'Se parte del '),
                          TextSpan(
                            text: 'futuro ',
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          TextSpan(text: 'de la educación'),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                              text:
                                  'Dejanos un correo al que podamos envíarte información sobre nuestra plataforma'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: SignUpFormWidget(),
                    ),
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

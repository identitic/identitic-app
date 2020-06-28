import 'package:flutter/material.dart';

import 'package:identitic/src/ui/pages/sign_in/widgets/half_button_widget.dart';
import 'package:identitic/src/ui/pages/sign_in/widgets/sign_in_form_widget.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 56),
                        child: Image(
                          height: 100,
                          image: AssetImage('assets/images/fingerprint.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: SignInFormWidget(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 56),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: 1 / 3,
                            child: HalfButton(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

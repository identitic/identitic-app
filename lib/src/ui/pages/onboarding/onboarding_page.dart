import 'package:flutter/material.dart';

import 'package:identitic/src/ui/pages/onboarding/widgets/slider_widget.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 56,
                ),
                child: Image(
                  height: 100,
                  image: AssetImage('assets/images/fingerprint.png'),
                ),
              ),
              SliderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

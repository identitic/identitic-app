import 'package:flutter/material.dart';

import 'package:identitic/pages/onboarding/widgets/slider_widget.dart';
import 'package:identitic/utils/constants.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverFillRemaining(
        hasScrollBody: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              SliderWidget(),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RouteName.sign_in),
                  color: Theme.of(context).buttonColor,
                  child: Text(
                    'Continuar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}

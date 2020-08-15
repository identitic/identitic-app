import 'package:flutter/material.dart';

import 'package:identitic/services/storage_service.dart';
import 'package:identitic/pages/main/main_page.dart';
import 'package:identitic/pages/onboarding/onboarding_page.dart';
import 'package:identitic/utils/constants.dart';
import 'package:identitic/utils/jwt.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkSignIn();
  }

  Future<void> _checkSignIn() async {
    final String token =
        await StorageService.instance.getEncrypted(StorageKey.token, null);
    if (token != null) {
      if (DateTime.now().millisecondsSinceEpoch - JWT.toMap(token)['exp'] > 0) {
        setState(() {
          isLoggedIn = false;
        });
      }
      setState(() {
          isLoggedIn = true;
        });
    } else {
      setState(() {
        isLoggedIn = token != null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _child(),
    );
  }

  Widget _child() {
    switch (isLoggedIn) {
      case true:
        return MainPage();
      case false:
        return OnboardingPage();
      default:
        return Container(
          color: Theme.of(context).buttonColor,
        );
    }
  }
}

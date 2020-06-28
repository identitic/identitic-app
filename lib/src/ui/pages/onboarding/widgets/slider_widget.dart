import 'package:flutter/material.dart';

import 'package:dots_indicator/dots_indicator.dart';

import 'package:identitic/src/ui/pages/onboarding/widgets/slider_item.dart';
import 'package:identitic/src/ui/widgets/identitic_button.dart';
import 'package:identitic/src/utils/constants.dart';

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  PageController _pageController;
  double _position = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController()
      ..addListener(() {
        setState(() {
          _position = _pageController.page;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 32,
        bottom: 16,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 351,
            child: PageView(
              controller: _pageController,
              children: _sliderItems,
            ),
          ),
          SizedBox(height: 16),
          DotsIndicator(
            decorator: DotsDecorator(
              color: Colors.grey[200],
              activeColor: Colors.grey,
            ),
            dotsCount: _sliderItems.length,
            position: _position,
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              right: 32,
              left: 32,
            ),
            child: IdentiticButton(
              onPressed: _nextPage,
              child: Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }

  List<SliderItem> _sliderItems = [
    SliderItem(
      image: 'assets/images/school.png',
      title: 'Bienvenido al futuro de la educación',
      text:
          'Uní tu escuela a Identitic, un sistema innovador, dinamico y divertido para todos',
    ),
    SliderItem(
      image: 'assets/images/blackboard.png',
      title: 'Estudiá más seguro y mejor',
      text:
          'Tus padres van a saber donde estás y vas a poder conectar tus estudios con la tecnología',
    ),
    SliderItem(
      image: 'assets/images/test.png',
      title: 'Conectá con tu escuela',
      text:
          'Mejorá la calidad de tus clases gracias a nuestro innovador sistema de asistencia',
    ),
  ];

  void _nextPage() {
    if (_pageController.page != _sliderItems.length - 1) {
      _pageController.nextPage(
        duration: Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamed(context, RouteName.sign_in);
    }
  }
}

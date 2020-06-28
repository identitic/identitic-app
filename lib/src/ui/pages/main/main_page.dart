import 'package:flutter/material.dart';
import 'package:identitic/src/ui/pages/calendar/calendar_page.dart';
import 'package:identitic/src/ui/pages/classes/classes_page.dart';
import 'package:identitic/src/ui/pages/home/home_page.dart';
import 'package:identitic/src/ui/pages/notifications/notifications_page.dart';
import 'package:identitic/src/ui/pages/profile/profile_page.dart';

import 'package:outline_material_icons/outline_material_icons.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changePage,
        currentIndex: _currentIndex,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink,
        items: [
          BottomNavigationBarItem(
            icon: Icon(OMIcons.home),
            activeIcon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(OMIcons.calendarToday),
            activeIcon: Icon(Icons.calendar_today),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(OMIcons.notifications, size: 26,),
            activeIcon: Icon(Icons.notifications),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(OMIcons.accountCircle),
            activeIcon: Icon(Icons.account_circle),
            title: Text(''),
          ),
        ],
      ),
    );
  }

  List<Widget> _pages = [
    HomePage(),
    ClassesPage(ClassPageType.calendar),
    NotificationsPage(),
    ProfilePage(),
  ];

  void _changePage(int newValue) {
    if (newValue != _currentIndex)
      setState(
        () {
          _currentIndex = newValue;
        },
      );
  }
}

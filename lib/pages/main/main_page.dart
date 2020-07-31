import 'package:flutter/material.dart';

import 'package:identitic/pages/calendar/calendar_page.dart';
import 'package:identitic/pages/home/home_page.dart';
import 'package:identitic/pages/notifications/notifications_page.dart';
import 'package:identitic/pages/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final List<Widget> _pages = [
    HomePage(),
    CalendarPage(),
    NotificationsPage(),
    ProfilePage(),
  ];
  int _currentIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: _pages.length,
    )..addListener(() {
        setState(() {
          _currentIndex = _tabController.index;
        });
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changePage,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 13,
              // backgroundColor: _currentIndex == 3
              //     ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              //     : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              child: CircleAvatar(
                radius: 12,
                backgroundImage:
                    AssetImage('assets/images/profile_picture.jpg'),
              ),
            ),
            title: Text(''),
          ),
        ],
      ),
    );
  }

  void _changePage(int newValue) {
    if (newValue != _currentIndex) {
      _tabController.animateTo(newValue);
      setState(() {
        _currentIndex = newValue;
      });
    }
  }
}

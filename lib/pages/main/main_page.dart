import 'package:flutter/material.dart';

import 'package:identitic/pages/calendar/calendar_page.dart';
import 'package:identitic/pages/home/home_page.dart';
import 'package:identitic/pages/notifications/notifications_page.dart';
import 'package:identitic/pages/profile/profile_page.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/utils/constants.dart';
import 'package:provider/provider.dart';

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
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
                radius: 13,
                backgroundImage:
                    Provider.of<AuthProvider>(context, listen: false)
                                .user
                                .profilePhoto !=
                            null
                        ? NetworkImage(apiBaseUrl +
                            "/" +
                            Provider.of<AuthProvider>(context, listen: false)
                                .user
                                .profilePhoto
                                .replaceFirst(r'\', "/"))
                        : AssetImage('assets/images/avatar.png')),
            label: '',
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

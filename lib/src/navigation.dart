import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scs_project/src/calendar.dart';
import 'package:scs_project/users/custom_user.dart';
import 'package:scs_project/src/globals.dart';
import 'package:scs_project/src/profile_page.dart';

class Navigation extends StatefulWidget {
  final CustomUser user;
  const Navigation({Key? key, required this.user}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  late CustomUser _currentUser;
  int _selectedIndex = 0;

  @override
  void initState()
  {
    _currentUser = widget.user;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _children = [
    ProfilePage(user: _currentUser,),
    Calendar(user: _currentUser,),
    Calendar(user: _currentUser,),
    ProfilePage(user: _currentUser),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

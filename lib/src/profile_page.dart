import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scs_project/src/calendar.dart';
import 'package:scs_project/database/database.dart';
import 'package:scs_project/src/globals.dart';
import 'package:scs_project/login/login_page.dart';
import 'package:scs_project/database/auth.dart';
import 'package:scs_project/users/custom_user.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ProfilePage extends StatefulWidget {
  final CustomUser user;

  const ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}


int _selectedIndex = 0;

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  late CustomUser _currentUser;

  @override
  void initState() {
    _selectedIndex = 0;
    _currentUser = widget.user;
    super.initState();
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Calendar(user: _currentUser),
        ),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_currentUser.getGroup().toString()),
            SizedBox(height: 16.0),
            Text(
              'EMAIL: ${_currentUser.email}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16.0),
            /*_currentUser.emailVerified
                ? Text(
                    'Email verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.green),
                  )
                : Text(
                    'Email not verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.red),
                  ),
            SizedBox(height: 16.0),
            _isSendingVerification
                ? CircularProgressIndicator()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isSendingVerification = true;
                          });
                          await _currentUser.sendEmailVerification();
                          setState(() {
                            _isSendingVerification = false;
                          });
                        },
                        child: Text('Verify email'),
                      ),
                      SizedBox(width: 8.0),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () async {
                          User? user = await Auth.refreshUser(_currentUser);

                          if (user != null) {
                            setState(() {
                              _currentUser = user;
                            });
                          }
                        },
                      ),
                    ],
                  ),*/
            SizedBox(height: 16.0),
            _isSigningOut
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        _isSigningOut = false;
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text('Sign out'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

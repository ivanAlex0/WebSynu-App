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
      body: Padding(
        padding: const EdgeInsets.only(left: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  const TextSpan(text: "Year of study:"),
                  TextSpan(
                      text: "               " + _currentUser.getYrOfStudy.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  const TextSpan(text: "First name:"),
                  TextSpan(
                      text: "                 " + _currentUser.getFirstName.toString(),
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.italic,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  const TextSpan(text: "Last name:"),
                  TextSpan(
                      text: "                 " + _currentUser.getLastName.toString(),
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.italic,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  const TextSpan(text: "Date of birth:"),
                  TextSpan(
                      text: "        " + _currentUser.getDateOfBirth.toString(),
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.italic,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  const TextSpan(text: "Group:"),
                  TextSpan(
                      text: "                           " + _currentUser.getGroup.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  const TextSpan(text: "Gender:"),
                  TextSpan(
                      text: "                        " + _currentUser.getGender.toString(),
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.italic,
                      )),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  const TextSpan(text: "Email:"),
                  TextSpan(
                      text: "                  " + _currentUser.getEmail.toString(),
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.italic,
                      )),
                ],
              ),
            ),
            SizedBox(height: 10.0),
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
            SizedBox(height: 40.0),
            _isSigningOut
                ? CircularProgressIndicator()
                : Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: ElevatedButton(
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
                        primary: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                ),
          ],
        ),
      ),
    );
  }
}

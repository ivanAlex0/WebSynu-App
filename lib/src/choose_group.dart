import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scs_project/users/custom_user.dart';
import 'package:scs_project/database/database.dart';
import 'package:scs_project/src/globals.dart';
import 'package:scs_project/login/login_page.dart';
import 'package:scs_project/src/profile_page.dart';

class ChooseGroup extends StatefulWidget {
  final CustomUser user;
  const ChooseGroup({Key? key, required this.user}) : super(key: key);

  @override
  _ChooseGroupState createState() => _ChooseGroupState();
}

class _ChooseGroupState extends State<ChooseGroup> {
  String _value = "Choose your group";
  String _error = "";

  late CustomUser _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Choose Group"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: DropdownButton<String>(
                value: _value,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: textColor,
                ),
                underline: Container(
                  height: 2,
                  color: textColor,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _value = newValue!;
                  });
                },
                items: <String>[
                  "Choose your group",
                  1.toString(),
                  2.toString(),
                  3.toString(),
                  4.toString()
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              child: const Text("Choose"),
              onPressed: () {
                setState(() {
                  int _group = int.tryParse(_value) ?? 0;
                  if (_group != 0) {
                    Database(uid: _currentUser.uid).updateUserData(_group);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  } else {
                    _error = "Choose a valid group";
                  }
                });
              },
            ),
            Text(
              _error,
              style: const TextStyle(color: Colors.red),
            )
          ],
        ));
  }
}

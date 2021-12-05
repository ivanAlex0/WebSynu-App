import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scs_project/database/auth.dart';
import 'package:scs_project/login/login_page.dart';
import 'package:scs_project/users/custom_user.dart';

class Settings extends StatefulWidget {
  final CustomUser user;
  const Settings({Key? key, required this.user}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late CustomUser _currentUser;

  final passwordController = TextEditingController();
  String _error = "";

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  void deleteAccount() async {
    String? callBack = await Auth.deleteUser(
        customUser: _currentUser, password: passwordController.text);
    _error = callBack == null ? "Null" : callBack.toString();
    if (_error == "Delete was successful") {
      //return to LogIn as the account was deleted
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else {
      setState(() {});
    }
  }

  void del() {
    setState(() {
      print(passwordController.text);
    });
  }

  void set(String value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          createTextForm(passwordController, "password", Icons.password,
              TextInputType.text, () {}),
          Center(
            child: ElevatedButton(
              child: const Text("Delete account"),
              onPressed: passwordController.text.isEmpty ? null : deleteAccount,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ),
          Text(
            _error,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Padding createTextForm(TextEditingController _controller, String _label,
          IconData? icon, TextInputType type, void Function()? onTap) =>
      Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        child: TextFormField(
          obscureText: true,
          keyboardType: type,
          controller: _controller,
          decoration: InputDecoration(
              icon: Icon(icon),
              labelText: _label,
              border: const UnderlineInputBorder()),
          onChanged: set,
          onTap: onTap,
        ),
      );
}

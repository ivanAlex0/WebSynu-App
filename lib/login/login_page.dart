import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scs_project/src/choose_group.dart';
import 'package:scs_project/database/database.dart';
import 'package:scs_project/login/register_page.dart';
import 'package:scs_project/database/auth.dart';
import 'package:scs_project/src/globals.dart';
import 'package:scs_project/src/navigation.dart';
import 'package:scs_project/users/custom_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: title,
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image.asset('assets/images/login_icon.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40, top: 20),
                    child: Text(
                      'Login Page',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailTextController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _passwordTextController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        _isProcessing
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: textColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  fixedSize: const Size(130, 65),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isProcessing = true;
                                    });

                                    User? user =
                                        await Auth.signInUsingEmailPassword(
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text,
                                    );

                                    setState(() {
                                      _isProcessing = false;
                                    });

                                    if (user != null) {
                                      String? email = user.email;
                                        String emailVer;
                                        if (email == null) {
                                          emailVer = "None";
                                        } else {
                                          emailVer = email;
                                        }
                                      if (await Database(uid: user.uid)
                                              .getUserGroup() ==
                                          NULL_ERROR) {
                                        CustomUser _currentUser = CustomUser(
                                            uid: user.uid,
                                            group: NULL_ERROR,
                                            email: emailVer);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChooseGroup(user: _currentUser),
                                          ),
                                        );
                                      } else {
                                        int group =
                                            await Database(uid: user.uid)
                                                .getUserGroup();
                                        CustomUser _currentUser = CustomUser(
                                            uid: user.uid,
                                            group: group,
                                            email: emailVer);
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Navigation(user: _currentUser),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/login_button.png',
                                  height: 50,
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 250, top: 90),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/images/login_new.png',
                              height: 35,
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(80, 40),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

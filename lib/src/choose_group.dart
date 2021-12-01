import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:scs_project/database/database.dart';
import 'package:scs_project/login/login_page.dart';
import 'package:scs_project/users/custom_user.dart';
import 'package:scs_project/src/globals.dart';

class ChooseGroup extends StatefulWidget {
  final CustomUser user;
  const ChooseGroup({Key? key, required this.user}) : super(key: key);

  @override
  _ChooseGroupState createState() => _ChooseGroupState();
}

class _ChooseGroupState extends State<ChooseGroup> {
  late CustomUser _currentUser;
  String _error = "";
  String _gender = "Gender";

  final yearOfStudyController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final groupController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    yearOfStudyController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    groupController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Complete your account information"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            createTextForm(yearOfStudyController, "Enter your year of study:",
                Icons.school_outlined, TextInputType.number, null),
            createTextForm(firstNameController, "Enter your first name:",
                Icons.person_add_alt_outlined, TextInputType.text, null),
            createTextForm(lastNameController, "Enter your last name:",
                Icons.person_add_alt_1_outlined, TextInputType.text, null),
            createTextForm(
              dateController,
              "Enter your date of birth:",
              Icons.date_range,
              TextInputType.none,
              () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(1950, 1, 1),
                  maxTime: DateTime(2005, 1, 1),
                  onConfirm: (date) {
                    dateController.text = date.toString().split(" ")[0];
                  },
                  currentTime: DateTime.now(),
                );
              },
            ),
            createTextForm(
              groupController,
              "Enter your group (number 1-4)",
              Icons.format_list_numbered_outlined,
              TextInputType.number,
              null,
            ),
            DropdownButton<String>(
              value: _gender,
              onChanged: (String? newValue) {
                setState(() {
                  _gender = newValue!;
                });
              },
              items: <String>[
                "Gender",
                "M",
                "F",
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              child: const Text("Submit"),
              onPressed: () {
                setState(() {
                  if (!validateInput()) {
                    print("Input is not valid");
                  } else {
                    Database(uid: _currentUser.uid).updateUserData(
                        int.parse(yearOfStudyController.text),
                        firstNameController.text,
                        lastNameController.text,
                        dateController.text,
                        int.parse(groupController.text),
                        _gender);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
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

  Padding createTextForm(TextEditingController _controller, String _label,
          IconData? icon, TextInputType type, void Function()? onTap) =>
      Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        child: TextFormField(
          keyboardType: type,
          controller: _controller,
          decoration: InputDecoration(
              icon: Icon(icon),
              labelText: _label,
              border: const UnderlineInputBorder()),
          onChanged: null,
          onTap: onTap,
        ),
      );

  bool validateInput() {
    if (yearOfStudyController.text.isEmpty) {
      _error = "Year of study cannot be null";
    } else if (!['1', '2', '3', '4'].contains(yearOfStudyController.text)) {
      _error = "Year of study must be 1, 2, 3 or 4";
    } else if (firstNameController.text.isEmpty) {
      _error = "First name cannot be null";
    } else if (lastNameController.text.isEmpty) {
      _error = "Last name cannot be null";
    } else if (dateController.text.isEmpty) {
      _error = "Date of birth cannot be null";
    } else if (groupController.text.isEmpty) {
      _error = "Group cannot be null";
    } else if (!['1', '2', '3', '4'].contains(groupController.text)) {
      _error = "The group must be 1, 2, 3 or 4";
    } else {
      _error = "";
      return true;
    }
    return false;
  }
}

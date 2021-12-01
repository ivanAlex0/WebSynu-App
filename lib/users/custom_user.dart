import 'package:flutter/cupertino.dart';

class CustomUser {
  final int yrOfStudy;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final int group;
  final String gender;
  final String uid;
  final String email;
  CustomUser(
      {Key? key,
      this.yrOfStudy = -1,
      this.firstName = "",
      this.lastName = "",
      this.dateOfBirth = "",
      required this.uid,
      this.group = -1,
      this.gender = "",
      required this.email});

  int get getGroup {
    return group;
  }

  String get getUid {
    return uid;
  }

  String get getEmail {
    return email;
  }

  int get getYrOfStudy {
    return yrOfStudy;
  }

  String get getFirstName {
    return firstName;
  }

  String get getLastName {
    return lastName;
  }

  String get getDateOfBirth {
    return dateOfBirth;
  }

  String get getGender {
    return gender;
  }
}

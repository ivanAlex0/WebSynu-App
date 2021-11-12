import 'package:flutter/cupertino.dart';

class CustomUser {
  final String uid;
  final int group;
  final String email;
  CustomUser(
      {Key? key, required this.uid, required this.group, required this.email});

  int getGroup() {
    return group;
  }

  void setGroup(int group) {
    group = group;
  }

  String getUid() {
    return uid;
  }
  String getEmail() {
    return email;
  }
}

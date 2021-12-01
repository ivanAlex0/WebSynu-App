import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scs_project/src/globals.dart';

class Database {
  final String uid;
  Database({required this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('Personal Data');

  Future deleteuser() {
    return brewCollection.doc(uid).delete();
  }

  Future updateUserData(int yrOfStudy, String firstName, String lastName,
      String dateOfBirth, int group, String gender) async {
    return await brewCollection.doc(uid).set({
      'Year of study': yrOfStudy,
      'First name': firstName,
      'Last name': lastName,
      'Date of birth': dateOfBirth,
      'Group': group,
      'Gender': gender,
    });
  }

  Future<int> getUserGroup() async {
    return brewCollection.doc(uid).get().then((value) {
      if (value.data() == null) {
        return NULL_ERROR;
      } else {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        return data['Group'];
      }
    });
  }

  Future<Map<String, dynamic>> getUserData() async {
    return brewCollection.doc(uid).get().then((value) {
      if (value.data() == null) {
        return {};
      } else {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        return data;
      }
    });
  }
}

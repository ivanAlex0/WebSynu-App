import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scs_project/src/globals.dart';

class Database {
  final String uid;
  Database({required this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('groups');

  Future updateUserData(int group) async {
    return await brewCollection.doc(uid).set({'group': group});
  }

  Future<int> getUserGroup() async {
    return brewCollection.doc(uid).get().then((value) {
      if (value.data() == null) {
        return NULL_ERROR;
      } else {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        return data['group'];
      }
    });
  }
}

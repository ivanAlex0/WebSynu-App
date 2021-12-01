import 'package:firebase_auth/firebase_auth.dart';
import 'package:scs_project/database/database.dart';
import 'package:scs_project/users/custom_user.dart';

class Auth {
  //For deleting a user
  static Future<String?> deleteUser({
    required CustomUser customUser,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: customUser.getEmail,
        password: password,
      );

      user = userCredential.user;
      user = auth.currentUser;

      if (user != null) {
        Database(uid: user.uid).deleteuser();
        user.delete();
        return 'Delete was successful';
      } else {
        return "Null user";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided.';
      }
    } catch (e) {
      return 'Exception <sad face>';
    }
  }

  // For registering a new user
  static Future<List<dynamic>?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    List<dynamic> errorAndUser = <dynamic>[];

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorAndUser.add('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorAndUser.add('The account already exists for that email.');
        print('The account already exists for that email.');
      }else {
        errorAndUser.add(e.code);
      }
    } catch (e) {
      print(e);
    }

    if(errorAndUser.isEmpty)
    {
      errorAndUser.add("Success.");
    }
    errorAndUser.add(user);
    return errorAndUser;
  }

  // For signing in an user (have already registered)
  static Future<List<dynamic>?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    List<dynamic> errorAndUser = <dynamic>[];

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorAndUser.add('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        errorAndUser.add('Wrong password provided.');
        print('Wrong password provided.');
      } else if (e.code == 'invalid-email') {
        errorAndUser.add('Invalid email provided.');
        print('Wrong password provided.');
      }
    }

    if (errorAndUser.isEmpty) {
      errorAndUser.add('Success.');
    }
    errorAndUser.add(user);
    return errorAndUser;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}

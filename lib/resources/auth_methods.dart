import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/model/user.dart' as model;
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some erroe occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        var uid = cred.user!.uid;

        model.User user = model.User(
          email: email,
          uid: uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firestore.collection('users').doc(uid).set(user.toJson());
        res = 'Success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-password') {
        res = 'The provided password is invalid. It must be a string with at least six characters.';
      } else if (e.code == 'invalid-email') {
        res = 'The provided Email is invalid. It must be a string email address.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'Success';
      } else {
        res = 'Please enter all the field';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        res = 'Email or Password is not found';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}

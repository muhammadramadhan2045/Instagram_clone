import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagrams_flutter/resources/storage_method.dart';
import 'package:instagrams_flutter/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String sandi,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Beberapa error terjadi";
    try {
      if (email.isNotEmpty ||
          sandi.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: sandi);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //add user ke database firestore or database
        model.User user = model.User(
          username: username,
          uid: credential.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());

        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        print('The email address is badly formatted');
      } else if (err.code == 'weak-password') {
        print(' Password should be at least 6 characters');
      } else if (err.code == 'email-already-in-use') {
        print('The email address is already in use by another account');
      }
      print(err.toString());
    }
    // catch (e) {
    //   res = e.toString();
    //   print(res);
    // }
    return res;
  }

  //logging in user
  Future<String> loginUser({
    required String email,
    required String sandi,
  }) async {
    String res = "Beberapa error terjadi";

    try {
      if (email.isNotEmpty || sandi.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: sandi);
        res = "success";
      } else {
        res = "Please enter al the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = "user not found";
      } else if (e.code == 'wrong-password') {
        res = "password is wrong";
      } else if (e.code == 'too-many-requests') {
        res = "too many request";
      } else {
        res = "disconnected";
      }
    }

    // catch (e) {
    //   res = e.toString();
    //   print(e.toString());
    // }
    return res;
  }

  //logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

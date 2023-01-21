import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagrams_flutter/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

        //add user ke database firestore
        _firestore.collection('users').doc(credential.user!.uid).set({
          'username': username,
          'uid': credential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

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
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagrams_flutter/screen/add_post_screen.dart';
import 'package:instagrams_flutter/screen/feed_screen.dart';
import 'package:instagrams_flutter/screen/profil_screen.dart';
import 'package:instagrams_flutter/screen/search_screen.dart';

const webScreenSize = 600;
final FirebaseAuth _auth = FirebaseAuth.instance;

List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreens(),
  AddPostScreen(),
  AddPostScreen(),
  ProfileScreen(uid: _auth.currentUser!.uid),
];

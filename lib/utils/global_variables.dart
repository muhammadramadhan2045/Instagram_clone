import 'package:flutter/material.dart';
import 'package:instagrams_flutter/screen/add_post_screen.dart';
import 'package:instagrams_flutter/screen/feed_screen.dart';
import 'package:instagrams_flutter/screen/search_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreens(),
  AddPostScreen(),
  const Center(
    child: Text("Asep "),
  ),
  const Center(
    child: Text("Tirta"),
  ),
];

import 'package:flutter/material.dart';
import 'package:instagrams_flutter/screen/add_post_screen.dart';
import 'package:instagrams_flutter/screen/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  const Center(
    child: Text("Aulia"),
  ),
  AddPostScreen(),
  const Center(
    child: Text("Asep "),
  ),
  const Center(
    child: Text("Tirta"),
  ),
];

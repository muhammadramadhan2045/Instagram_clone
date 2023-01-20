import 'package:flutter/material.dart';
import 'package:instagrams_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagrams_flutter/responsive/responsive_layout.dart';
import 'package:instagrams_flutter/responsive/web_screen_layout.dart';
import 'package:instagrams_flutter/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        home: const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenlayout(),
        ));
  }
}

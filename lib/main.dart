import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagrams_flutter/screen/login_screen.dart';
import 'package:instagrams_flutter/screen/signup_screen.dart';
import 'package:instagrams_flutter/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAjAe6jb3lafcTT21cQIi-VBy2A8qrn0wQ",
        appId: "1:426571681013:web:e67cbeef03daa2d50849bc",
        messagingSenderId: "426571681013",
        projectId: "instagram-clone-f4939",
        storageBucket: "instagram-clone-f4939.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

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
      home: const LoginScreen(),
    );
  }
}

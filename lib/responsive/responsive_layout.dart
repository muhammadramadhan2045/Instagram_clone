import 'package:flutter/material.dart';
import 'package:instagrams_flutter/providers/user_provider.dart';
import 'package:instagrams_flutter/utils/dimesion.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final webScreenLayout;
  final mobileScreenLayout;
  const ResponsiveLayout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          //webscreen
          return widget.webScreenLayout;
        }
        //mobile
        return widget.mobileScreenLayout;
      },
    );
  }
}

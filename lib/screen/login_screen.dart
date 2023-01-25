import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagrams_flutter/resources/auth_method.dart';
import 'package:instagrams_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagrams_flutter/responsive/responsive_layout.dart';
import 'package:instagrams_flutter/responsive/web_screen_layout.dart';
import 'package:instagrams_flutter/screen/signup_screen.dart';
import 'package:instagrams_flutter/utils/colors.dart';
import 'package:instagrams_flutter/utils/global_variables.dart';
import 'package:instagrams_flutter/utils/utils.dart';
import 'package:instagrams_flutter/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController sandiController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    sandiController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods()
        .loginUser(email: emailController.text, sandi: sandiController.text);

    if (res == "success") {
      //navigate to homescreen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          webScreenLayout: WebScreenlayout(),
          mobileScreenLayout: MobileScreenLayout(),
        ),
      ));
    } else {
      //
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //svg image
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              //text field for email
              TextFieldInput(
                textEditingController: emailController,
                hintText: 'Masukan Emailmu',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              //text field for sandi
              TextFieldInput(
                textEditingController: sandiController,
                hintText: 'Masukan Sandimu',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),

              //button login
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: primaryColor,
                          ),
                        )
                      : const Text("Login"),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //transitioning to signing up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Belum punya akun ? "),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Container(
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

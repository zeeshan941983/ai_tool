import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:wezee_tool/components/color.dart';
import 'package:wezee_tool/repo/login_repo.dart';
import 'package:wezee_tool/widgets/custom_button.dart';
import 'package:wezee_tool/widgets/cutom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void emptyMessage() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill all fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.mainorange,
          textColor: AppColors.mainWhite,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Text(
                "Hello \nAgain!",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 70),
              CustomTextfield(
                controller: emailController,
                hintText: 'Enter Email',
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: passwordController,
                isfalse: true,
                hintText: 'Enter Password',
              ),
              const SizedBox(height: 20),
              CustomButton(
                height: 55,
                width: 350,
                bgColor: AppColors.buttonLyellow,
                title: 'Log in',
                titleColor: AppColors.mainblack,
                onPressed: () {
                  emptyMessage();
                  Loginrepo().loginUser(emailController.text.trim(),
                      passwordController.text.trim(), context);
                },
              ),
              const SizedBox(height: 100),
              Text("I don't have an account",
                  style: GoogleFonts.poppins(color: Colors.white)),
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.mainWhite,
                  ),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'signup'),
                  child: Text(
                    "Sign up",
                    style: GoogleFonts.poppins(fontSize: 18),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}

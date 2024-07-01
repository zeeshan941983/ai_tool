import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wezee_tool/components/color.dart';
import 'package:wezee_tool/repo/login_repo.dart';
import 'package:wezee_tool/widgets/custom_button.dart';
import 'package:wezee_tool/widgets/cutom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Loginrepo loginrepo = Loginrepo();
  void registercheck() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill all fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.mainorange,
          textColor: AppColors.mainWhite,
          fontSize: 16.0);
      emailController.clear();
      passwordController.clear();
      nameController.clear();
    } else {
      loginrepo.registerUser(emailController.text, passwordController.text);
      emailController.clear();
      passwordController.clear();
      nameController.clear();
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
              const SizedBox(height: 50),
              Text(
                "Welcome \nBack!",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 70),
              CustomTextfield(
                controller: nameController,
                hintText: 'Enter Name',
              ),
              const SizedBox(height: 20),
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
                  title: 'Sign Up',
                  titleColor: AppColors.mainblack,
                  onPressed: registercheck),
              const SizedBox(height: 100),
              Text("Already have an account",
                  style: GoogleFonts.poppins(color: Colors.white)),
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.mainWhite,
                  ),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.poppins(fontSize: 18),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}

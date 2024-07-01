import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:wezee_tool/components/color.dart';

import '../../widgets/custom_button.dart';

class MaiAuthScreen extends StatefulWidget {
  const MaiAuthScreen({super.key});

  @override
  State<MaiAuthScreen> createState() => _MaiAuthScreenState();
}

class _MaiAuthScreenState extends State<MaiAuthScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              'Log In \nWith',
              style: GoogleFonts.lexendDeca(fontSize: 39, color: Colors.white),
            ),
            const SizedBox(height: 70),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  height: 50,
                  width: 300,
                  bgColor: AppColors.mainblack,
                  title: 'Log in with Email ',
                  sideColor: AppColors.buttonLpurple,
                  titleColor: AppColors.buttonLpurple,
                  onPressed: () => Navigator.pushNamed(context, 'login'),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  height: 50,
                  width: 300,
                  bgColor: AppColors.mainblack,
                  title: 'Log in with Apple ',
                  sideColor: AppColors.buttonLpurple,
                  titleColor: AppColors.buttonLpurple,
                  icon: FontAwesomeIcons.apple,
                  onPressed: () {
                    // Loginrepo().signInWithApple(context);
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  height: 50,
                  width: 300,
                  bgColor: AppColors.mainblack,
                  title: 'Log in with Google ',
                  sideColor: AppColors.buttonLpurple,
                  titleColor: AppColors.buttonLpurple,
                  icon: FontAwesomeIcons.google,
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                CustomButton(
                  height: 50,
                  width: 300,
                  bgColor: AppColors.mainblack,
                  title: 'Log in with Facebook ',
                  sideColor: AppColors.buttonLpurple,
                  titleColor: AppColors.buttonLpurple,
                  icon: FontAwesomeIcons.facebook,
                  onPressed: () {},
                ),
                const SizedBox(height: 100),
                Text("I don't have an account",
                    style: GoogleFonts.poppins(color: Colors.white)),
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.mainWhite,
                    ),
                    onPressed: () => Navigator.pushNamed(context, 'signup'),
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ))
              ],
            ),
          ],
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Color bgColor;
  final Color? sideColor;
  final Color? titleColor;
  final String title;
  final IconData? icon;
  final Function()? onPressed;

  const CustomButton(
      {super.key,
      required this.height,
      required this.width,
      required this.bgColor,
      this.sideColor,
      required this.title,
      this.titleColor,
      this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          backgroundColor: bgColor,
          foregroundColor: titleColor ?? Colors.white,
          side: BorderSide(color: sideColor ?? Colors.transparent, width: 1)),
      child: icon != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ],
            )
          : Text(
              title,
              style: GoogleFonts.poppins(fontSize: 18),
            ),
    );
  }
}

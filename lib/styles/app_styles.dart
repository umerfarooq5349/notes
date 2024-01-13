import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color whiteColor = const Color(0xffffffff);
  static Color bgColor = const Color(0xFFC0B4EB);
  static Color brown = const Color(0xFF473B2D);
  static List<List<Color>> gradients = [
    [const Color(0xFF6448FE), const Color(0xFF5FC6FF)],
  ];
  static Color success = const Color(0xFF00FF33);
  static Color error = const Color(0xFFFF0000);
  static List<Color> bgGradient = [
    const Color(0xFF4776E6),
    const Color(0xFF8E54E9)
  ];

  static Color purpule = const Color(0xFF8E54E9);
  static TextStyle appBar = GoogleFonts.aDLaMDisplay(
      fontSize: 28, fontWeight: FontWeight.bold, color: whiteColor);
  static TextStyle mainTitle = GoogleFonts.roboto(
      fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor);

  static TextStyle mainContent = GoogleFonts.nunito(
      fontSize: 16, fontWeight: FontWeight.normal, color: whiteColor);
  static TextStyle hintText = GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: whiteColor.withOpacity(0.8));

  static TextStyle date = GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.w500, color: whiteColor);
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      alignment: Alignment.center,
      child: Divider(
        color: AppStyle.purpule,
        thickness: MediaQuery.of(context).size.width * 0.002,
        endIndent: MediaQuery.of(context).size.width * 0.01,
      ),
    );
  }
}

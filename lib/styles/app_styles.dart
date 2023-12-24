import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color whiteColor = const Color(0xffffffff);
  static Color mainColor = const Color(0xffD6EBFF);
  static Color accentColor = const Color(0xff0065ff);
  static Color bgColor = const Color(0xFFC0B4EB);

  static List<List<Color>> gradients = [
    [const Color(0xFF6448FE), const Color(0xFF5FC6FF)],
    [const Color(0xFF61A3FE), const Color(0xFF63FFD5)],
    [const Color(0xFF708090), const Color(0xFFFF8484)],
    [const Color(0xff764BA2), const Color(0xFF667EEA)]
  ];
  static List<Color> bgGradient = [
    const Color(0xFF4776E6),
    const Color(0xFF8E54E9)
  ];

  static Color purpule = const Color(0xFF473B2D);
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

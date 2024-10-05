import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalColors {
  static const Color primaryColor = Color(0xff088180);
  static const Color bgColor = Color(0xfff1f3f5);
  static const Color flButtonColor = Color(0xff3370cc);
  static const Color kGreyTextColor = Color(0xFF929292);
  static const Color kWhiteLight = Color(0xFFF3F3F3);
  static const Color kGreyLight = Color(0xFFD6D6D6);
  static const Color kGreyBlack = Color(0xFF464646);
  static const Color working = Color(0xFF00FF47);
  static const Color borderContainer = Color(0xffEAEAEA);
  static const Color greyMedium = Color(0xffBFBFBF);
  static const Color kBorderColorTextField = Color(0xFFC2C2C2);
  static const Color kDarkWhite = Color(0xFFF1F7F7);
  static const Color bgSearch = Color(0xffe4e6ed);
  static const Color primaryWebColor = Color(0xff2d2d4a);
  static const Color bgWebColor = Color(0xfffcfdff);
  static const Color hintMenuTextColor = Color(0xff9a9bb0);
  static const Color bgWebMenuColor = Color(0xffff3979);
  static const Color borderWebColor = Color(0xffdde5f4);
  static const Color bgButton = Color.fromARGB(255, 242, 243, 245);
  static const Color bgButton1 = Color.fromARGB(255, 239, 250, 244);
  static const Color bgButton2 = Color.fromARGB(255, 252, 238, 235);
  static const Color successColor = Color.fromARGB(255, 3, 169, 39);
  static const Color errorColor = Color.fromARGB(255, 236, 15, 22);
  static const Color appBar1 = Color(0xFF007AD0);
  static const Color appBar2 = Color(0xff0046d0);
  static const Color appBar3 = Color(0xff008bd0);
  static const Color appBar4 = Color(0xff00aed0);
  static Color getTextTitle(BuildContext context) {
    return Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF000743);
  }
}

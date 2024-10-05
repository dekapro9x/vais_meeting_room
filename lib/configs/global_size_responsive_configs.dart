import 'package:flutter/material.dart';

class SizeConfigResponsiveApp {
  final BuildContext context;

  static const double designWidth = 375.0;
  static const double designHeight = 812.0;

  SizeConfigResponsiveApp(this.context);

   double getWidthDesign() {
    return designWidth;
  }

    double getHeightDesign() {
    return designHeight;
  }

  double getWidthReposive(double inputWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (inputWidth / designWidth) * screenWidth;
  }

  double getHeightResponsive(double inputHeight) {
    double screenHeight = MediaQuery.of(context).size.height;
    return (inputHeight / designHeight) * screenHeight;
  }

  double getFontSizeResponsive(double inputFontSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  double designWidth = 375.0; 
  double responsiveFontSize = (inputFontSize / designWidth) * screenWidth;
  double scaleFactor = 0.9; 
  return responsiveFontSize * scaleFactor;
}
}

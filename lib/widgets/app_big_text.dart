import 'package:app_base_flutter/configs/global_size_responsive_configs.dart';
import 'package:flutter/material.dart';

class AppBigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextAlign? textAlign;

  const AppBigText({
    super.key, 
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 14,
    this.overFlow = TextOverflow.ellipsis,
    this.fontWeight,
    this.maxLines = 1,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfigResponsiveApp sizeConfigResponsive =
        SizeConfigResponsiveApp(context);
    return Text(
      text,
      maxLines: maxLines,
      overflow: overFlow,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: sizeConfigResponsive.getFontSizeResponsive(size),
        fontFamily: 'Roboto',
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}

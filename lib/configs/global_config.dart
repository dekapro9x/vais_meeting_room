import 'dart:io';

import 'package:flutter/material.dart';

class GlobalConfigs {
  static const String appName = 'BeoTranDevApp';
  static const supportedLocales = [
    Locale('en'),
    Locale('vi'),
  ];
  static final String versionAppBuildLocal = Platform.isIOS ? '1.0.0' : '1.0.0';
  static const String kBaseUrl = 'https://vais.vn/';
}

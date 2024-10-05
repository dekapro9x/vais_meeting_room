import 'package:app_base_flutter/screens/bottom_navigator_screen/bottom_navigation.dart';
import 'package:app_base_flutter/screens/splash_screen/splash_screen_logo_app.dart';
import 'package:app_base_flutter/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_base_flutter/screens/vais_list_room_manage/list_room_screen.dart';

class RouteGenerator {
  static const String splashScreen = '/';
  static const String policy = 'policy_screen';
  static const String welcomeScreen = 'welcome_screen';
  static const String bottomNavigationBar = 'bottom-navigation';
  static const String listRoomManage = 'vais_list_room_manage';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          maintainState: false,
          builder: (context) => const SplashScreenLogoApp(),
          settings: settings,
        );
      case welcomeScreen:
        return MaterialPageRoute(
          maintainState: true,
          builder: (context) => const WelcomeScreen(),
          settings: settings,
        );
      case bottomNavigationBar:
        return MaterialPageRoute(
            builder: (context) => BottomNavigation.providers(),
            settings: settings,
            maintainState: false);
      //Danh sách phòng họp:
      case listRoomManage:
        return MaterialPageRoute(
            builder: (context) => const ListRoomScreen(isBooking: false),
            settings: settings,
            maintainState: false);
      default:
        return MaterialPageRoute(
          builder: (context) => Container(),
          settings: settings,
        );
    }
  }
}

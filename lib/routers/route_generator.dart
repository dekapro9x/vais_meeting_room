import 'package:app_base_flutter/common/log_utils.dart';
import 'package:app_base_flutter/models/home/response/room_list_response.dart';
import 'package:app_base_flutter/screens/bottom_navigator_screen/bottom_navigation.dart';
import 'package:app_base_flutter/screens/splash_screen/splash_screen_logo_app.dart';
import 'package:app_base_flutter/screens/vais_booking_detail/vais_room_meeting_booking_detail.dart';
import 'package:app_base_flutter/screens/vais_list_room_manage/list_room_screen.dart';
import 'package:app_base_flutter/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String splashScreen = '/';
  static const String policy = 'policy_screen';
  static const String welcomeScreen = 'welcome_screen';
  static const String bottomNavigationBar = 'bottom-navigation';
  static const String listRoomManage = 'vais_list_room_manage';
  static const String vaisBookingDetail = 'vais_booking_detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
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
          maintainState: false,
        );
      // Danh sách phòng họp:
      case listRoomManage:
        return MaterialPageRoute(
          builder: (context) => const ListRoomScreen(isBooking: false),
          settings: settings,
          maintainState: false,
        );
      // Màn chi tiết phòng họp:
      case vaisBookingDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null && args['roomMeetingDetail'] is Room) {
          final roomMeetingDetail = args['roomMeetingDetail'] as Room;
          logWithColor("Chi tiết room họp: ${roomMeetingDetail.name}", red);
          return MaterialPageRoute(
            builder: (context) =>
                RoomMeetingBookingDetailScreen(room: roomMeetingDetail),
          );
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR: Không tìm thấy route!'),
        ),
      ),
    );
  }
}

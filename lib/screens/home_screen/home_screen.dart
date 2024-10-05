import 'dart:async';

import 'package:app_base_flutter/common/log_utils.dart';
import 'package:app_base_flutter/configs/global_images.dart';
import 'package:app_base_flutter/screens/vais_list_room_manage/list_room_screen.dart';
import 'package:app_base_flutter/services/event_bus_services.dart';
import 'package:app_base_flutter/services/navigations_servicces.dart';
import 'package:flutter/material.dart';
import 'package:app_base_flutter/screens/vais_my_booking_room/my_boooking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_base_flutter/screens/home_screen/cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  static MultiBlocProvider providers() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
        ),
      ],
      child: const HomeScreen(),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final NavigationService navigationService = NavigationService();
  late PageController pageController;
  int _currentPage = 0;
  Timer? timerRunanimations;

  final List<String> _bannerImages = [
    GlobalImages.intro1,
    GlobalImages.intro2,
    GlobalImages.intro3,
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _currentPage);
    //Lấy số lượng badger trong state cubit home:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startAutoScrollAnimations();
      final badgeCount = context.read<HomeCubit>().state.data.badgeMyBooking;
      logWithColor('Số lượng badge my booking: $badgeCount', red);
    });
  }

  void startAutoScrollAnimations() {
    timerRunanimations =
        Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    timerRunanimations?.cancel();
    pageController.dispose();
    super.dispose();
  }

  Widget renderBuildBanner() {
    return Stack(
      children: [
        Container(
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: PageView.builder(
              controller: pageController,
              itemCount: _bannerImages.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  _bannerImages[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_bannerImages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: _currentPage == index ? 12.0 : 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.white : Colors.grey,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget renderBuildMenuItem(
      String title, IconData icon, Color color, int index, int badgeCount) {
    logWithColor(
        'Số lượng badge my booking đã cập nhật vào cubitState: $badgeCount',
        red);
    return GestureDetector(
      onTap: () {
        logWithColor("Item menu: $title", red);
        switch (index) {
          case 0:
            navigationService.navigate(
                context, const ListRoomScreen(isBooking: false));
            break;
          case 1:
            navigationService.navigate(context, const MyBookingScreen());
            break;
          case 2:
            logWithColor("Ấn vào menu số 2: $title", red);
            String eventMessageBusEmitActiveBottomMenuIndex2 =
                'ACTIVE_BOTTOM_MENU_INDEX_2';
            EventBusServices.fireEventEmit(
                MyCustomEvent(eventMessageBusEmitActiveBottomMenuIndex2));
            break;
          case 3:
            navigationService.navigate(
                context, const ListRoomScreen(isBooking: true));
            break;
          default:
            break;
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              if (badgeCount > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 35,
                      minHeight: 35,
                    ),
                    child: Center(
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderBuildMenuTop() {
    final badgeCountBookingSuccess =
        context.read<HomeCubit>().state.data.badgeMyBooking;
    logWithColor(
        'Số lượng badge my booking đã cập nhật vào cubitState: $badgeCountBookingSuccess',
        red);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          renderBuildMenuItem(
              "Danh sách phòng họp", Icons.meeting_room, Colors.green, 0, 0),
          renderBuildMenuItem("Lịch họp của tôi", Icons.event, Colors.blue, 1,
              badgeCountBookingSuccess),
          renderBuildMenuItem(
              "Quản lý phòng họp", Icons.settings, Colors.red, 2, 0),
        ],
      ),
    );
  }

  Widget renderBuildMenuBottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          renderSpecialMenuItem(
              "Đặt lịch họp", Icons.schedule, Colors.orangeAccent, 3),
        ],
      ),
    );
  }

  Widget renderSpecialMenuItem(
      String title, IconData icon, Color color, int index) {
    return GestureDetector(
      onTap: () {
        logWithColor("Item menu: $title", red);
        switch (index) {
          case 3:
            navigationService.navigate(
                context, const ListRoomScreen(isBooking: true));
            break;
          default:
            break;
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 8,
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.orange.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(4, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackground() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple.shade300.withOpacity(0.5),
            ),
          ),
        ),
        Positioned(
          bottom: -120,
          right: -60,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent.shade100.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trang Chủ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          buildBackground(),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                renderBuildBanner(),
                const SizedBox(height: 24),
                renderBuildMenuTop(),
                const SizedBox(height: 24),
                renderBuildMenuBottom()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

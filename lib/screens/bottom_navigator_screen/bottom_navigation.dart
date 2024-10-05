import 'dart:core';

import 'package:app_base_flutter/common/log_utils.dart';
import 'package:app_base_flutter/configs/global_colors.dart';
import 'package:app_base_flutter/configs/global_images.dart';
import 'package:app_base_flutter/configs/global_size_responsive_configs.dart';
import 'package:app_base_flutter/configs/storages/app_prefs.dart';
import 'package:app_base_flutter/screens/home_screen/cubit/home_cubit.dart';
import 'package:app_base_flutter/screens/home_screen/home_screen.dart';
import 'package:app_base_flutter/screens/vais_configure_room_availability/vais_config_room.dart';
import 'package:app_base_flutter/screens/vais_list_room_manage/list_room_screen.dart';
import 'package:app_base_flutter/services/event_bus_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavigation extends StatefulWidget {
  final int? tabIndex;
  const BottomNavigation({
    super.key,
    this.tabIndex,
  });

  static MultiBlocProvider providers({int? tabIndex}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
        ),
      ],
      child: BottomNavigation(
        tabIndex: tabIndex,
      ),
    );
  }

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late PersistentTabController controller;
  bool hasLogged = false;
  int unreadCount = 0;
  int indexTabBottomActive = 0;
  bool isVisibleNavigationMenuBar = true;
  final AppPrefStorage _appPref = AppPrefStorage();

  @override
  void initState() {
    super.initState();
    _appPref.init();
    listenEventBusEmitChangeTabIndex();
    controller = PersistentTabController(initialIndex: widget.tabIndex ?? 0);
    controller.addListener(onChangeMenuTabBottomIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Lắng nghe sự kiện ấn vào avatar thì active bottom tab sang tab 4:
  Future<void> listenEventBusEmitChangeTabIndex() async {
    EventBusServices.listenOnEvent((MyCustomEvent event) {
      if (event.message == 'ACTIVE_BOTTOM_MENU_INDEX_2') {
        setState(() {
          controller.jumpToTab(1);
        });
      }
    });
    return Future.value();
  }

  Future<void> onChangeMenuTabBottomIndex() async {
    logWithColor("Bottom tab index: ${controller.index}", red);
    switch (controller.index) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      default:
    }
    setState(() {
      indexTabBottomActive = controller.index;
    });
  }

  //Danh sách màn hình active theo Bottom tab:
  List<Widget> buildScreen() {
    return [
      HomeScreen(),
      VaisConfigRoomAdmin(),
      ListRoomScreen(isBooking: true),
    ];
  }

  List<PersistentBottomNavBarItem> buildCustomListItemBottomTab() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          GlobalImages.homeSelected,
        ),
        title: 'Trang chủ'.tr,
        activeColorPrimary: GlobalColors.primaryColor,
        inactiveIcon: SvgPicture.asset(
          GlobalImages.home,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          GlobalImages.settingRoom,
        ),
        title: 'Quản lý'.tr,
        activeColorPrimary: GlobalColors.primaryColor,
        inactiveIcon: SvgPicture.asset(
          GlobalImages.settingRoom,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          GlobalImages.mettingRoom,
        ),
        title: 'Đặt phòng'.tr,
        activeColorPrimary: GlobalColors.primaryColor,
        inactiveIcon: SvgPicture.asset(
          GlobalImages.mettingRoom,
        ),
      ),
    ];
  }

  void onChangeBottomTabIndex(BuildContext context) async {
    switch (indexTabBottomActive) {
      case 0:
        _appPref.init();
        final getListRoomBoooking =
            await _appPref.getListRoomMeetingBookingSuccess();
        logWithColor(
            "Gắn số lượng badger: ${getListRoomBoooking.length}", green);
        context
            .read<HomeCubit>()
            .setDataNumberBadgerMyBookingRoom(getListRoomBoooking.length);
        break;
      case 1:
        break;
      case 2:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    bool shouldHideBottomNav = true;
    SizeConfigResponsiveApp sizeConfigReponsive =
        SizeConfigResponsiveApp(context);
    return Visibility(
      visible: shouldHideBottomNav,
      child: PersistentTabView(
        controller: controller,
        context,
        navBarHeight: sizeConfigReponsive.getWidthReposive(60),
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
        screens: buildScreen(),
        items: buildCustomListItemBottomTab(),
        onItemSelected: (int indexBottomTabSelect) => {
          onChangeBottomTabIndex(context),
          logWithColor("Item bottom tab select: $indexBottomTabSelect", red)
        },
        backgroundColor: Colors.white,
        decoration: const NavBarDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 5,
              offset: Offset(0, -2),
              spreadRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        navBarStyle: NavBarStyle.style3,
        resizeToAvoidBottomInset: false,
        stateManagement: true,
        isVisible: isVisibleNavigationMenuBar,
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(),
        ),
      ),
    );
  }
}

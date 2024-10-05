import 'package:after_layout/after_layout.dart';
import 'package:app_base_flutter/common/log_utils.dart';
import 'package:app_base_flutter/configs/global_config.dart';
import 'package:app_base_flutter/languages/app_translation.dart';
import 'package:app_base_flutter/routers/route_generator.dart';
import 'package:bmprogresshud/progresshud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:app_base_flutter/screens/splash_screen/splash_screen_logo_app.dart';
import 'package:app_base_flutter/configs/get_it/get_it.dart';
import 'package:app_base_flutter/configs/storages/app_prefs.dart';
import 'package:app_base_flutter/models/home/response/room_list_response.dart';

void main() async {
  logWithColor('BeoTranDev...Run main()', green);
  //Kiểm tra WidgetsFlutterBinding.ensureInitialized() đã thực hiện xong mới chạy tiếp logic (Không lỗi nếu chưa thực hiện xong)
  WidgetsFlutterBinding.ensureInitialized();
  //Đăng kí khởi tạo GetX và dependencies:
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with WidgetsBindingObserver, AfterLayoutMixin {
  final List<AppLifecycleState> _stateHistoryList = <AppLifecycleState>[];
  final AppPrefStorage _appPref = AppPrefStorage();
  final List<Map<String, dynamic>> roomsMeetingManage = [
    {
      "name": "Phòng Họp A",
      "description": "Sức chứa 10 người",
      "status": "available",
      "openingHours": "07:00 AM",
      "closingHours": "07:00 PM",
      "isActive": false,
      "bookedTime": "Không có",
    },
    {
      "name": "Phòng Họp B",
      "description": "Sức chứa 20 người",
      "status": "booked",
      "openingHours": "07:00 AM",
      "closingHours": "07:00 PM",
      "isActive": true,
      "bookedTime": "10:00 AM - 11:00 AM",
    },
    {
      "name": "Phòng Họp C",
      "description": "Sức chứa 15 người",
      "status": "booked",
      "openingHours": "08:00 AM",
      "closingHours": "05:00 PM",
      "isActive": false,
      "bookedTime": "13:00 PM - 15:00 PM",
    },
    {
      "name": "Phòng Họp D",
      "description": "Sức chứa 8 người",
      "status": "available",
      "openingHours": "10:00 AM",
      "closingHours": "04:00 PM",
      "isActive": false,
      "bookedTime": "02:00 PM - 03:00 PM",
    },
    {
      "name": "Phòng Họp E",
      "description": "Sức chứa 12 người",
      "status": "available",
      "openingHours": "08:30 AM",
      "closingHours": "06:30 PM",
      "isActive": false,
      "bookedTime": "Không có",
    },
  ];
  @override
  Future<void> afterFirstLayout(BuildContext context) async {}

  @override
  void initState() {
    super.initState();
    saveRoomMeetingList();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance.addObserver(this);
      if (WidgetsBinding.instance.lifecycleState != null) {
        _stateHistoryList.add(WidgetsBinding.instance.lifecycleState!);
      }
    }
  }

  Future<void> saveRoomMeetingList() async {
    await _appPref.init();
    List<Room> roomsList =
        roomsMeetingManage.map((roomJson) => Room.fromJson(roomJson)).toList();
    logWithColor('Danh sách room meeting: $roomsList', red);
    await _appPref.setListRoomMeetingManage(rooms: roomsList);
  }

  bool alreadyAddedOverlays = false;
  @override
  Widget build(BuildContext context) {
    return ProgressHud(
      isGlobalHud: true,
      child: GetMaterialApp(
        title: GlobalConfigs.appName,
        home: LayoutBuilder(
          builder: (layoutContext, constraints) {
            return const SplashScreenLogoApp();
          },
        ),
        locale: Get.locale ?? const Locale('vi'),
        fallbackLocale: const Locale('vi'),
        translationsKeys: AppTranslation.translations,
        supportedLocales: GlobalConfigs.supportedLocales,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: Get.key,
      ),
    );
  }
}

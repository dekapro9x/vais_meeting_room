import 'package:app_base_flutter/common/log_utils.dart';
import 'package:app_base_flutter/configs/storages/app_prefs.dart';
import 'package:app_base_flutter/models/home/response/room_list_response.dart';
import 'package:app_base_flutter/screens/vais_booking_detail/vais_room_meeting_booking_detail.dart';
import 'package:app_base_flutter/services/navigations_servicces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ListRoomScreen extends StatefulWidget {
  final bool isBooking;
  const ListRoomScreen({Key? key, required this.isBooking}) : super(key: key);

  @override
  _ListRoomScreenState createState() => _ListRoomScreenState();
}

class _ListRoomScreenState extends State<ListRoomScreen>
    with RouteAware, WidgetsBindingObserver {
  final AppPrefStorage _appPref = AppPrefStorage();
  List<Room> roomMeetingState = [];
  final NavigationService navigationService = NavigationService();
  final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  @override
  void initState() {
    super.initState();
    getListRoomMeetingManage();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    getListRoomMeetingManage();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getListRoomMeetingManage();
    }
  }

  //Lấy danh sách phòng họp được quản lý:
  Future<void> getListRoomMeetingManage() async {
    logWithColor('Lấy danh sách phòng họp được quản lý', yellow);
    await _appPref.init();
    final listRooomChat = await _appPref.getListRoomMeetingManage();
    setState(() {
      roomMeetingState = listRooomChat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh sách phòng họp',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade200, Colors.blueAccent.shade100],
          ),
        ),
        child: roomMeetingState.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: roomMeetingState.length,
                  itemBuilder: (context, index) {
                    return renderBuildRoomCard(roomMeetingState[index]);
                  },
                ),
              )
            : const Center(
                child: Text(
                  'Không có phòng họp nào.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
      ),
    );
  }

  Widget renderBuildRoomCard(Room room) {
    bool isAvailable = room.status == "available";
    bool isActive = room.isActive;
    return InkWell(
        onTap: () {
          logWithColor('Nhấn vào phòng họp: ${room.name}', red);
          if (widget.isBooking) {
            navigationService.navigate(
                context, RoomMeetingBookingDetailScreen(room: room));
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Icon(
                        isActive
                            ? Icons.play_circle_fill
                            : Icons.do_not_disturb_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            room.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.meeting_room,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey[300]),
                const SizedBox(height: 8),
                // Thời gian mở cửa và đóng cửa
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.deepPurple,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Giờ mở cửa: ${room.openingHours}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.deepPurple,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Giờ đóng cửa: ${room.closingHours}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Trạng thái hoạt động của phòng
                Row(
                  children: [
                    Icon(
                      isActive ? Icons.check_circle : Icons.cancel,
                      color: isActive ? Colors.green : Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isActive
                          ? 'Phòng họp đang hoạt động'
                          : 'Phòng họp không hoạt động',
                      style: TextStyle(
                        fontSize: 14,
                        color: isActive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Thời gian đặt lịch của phòng
                if (room.bookedTimes.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Thời gian đặt lịch:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...room.bookedTimes.map((time) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.event_note,
                                color: Colors.deepPurple,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  time,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                //Thông tin phòng ban đặt lịch:
                if (room.departments.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Phòng ban đặt lịch:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...room.departments.map((department) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.group,
                                color: Colors.deepPurple,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  department,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  )
              ],
            ),
          ),
        ));
  }
}

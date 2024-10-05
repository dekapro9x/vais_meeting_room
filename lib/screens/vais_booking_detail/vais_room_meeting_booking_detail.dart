import 'package:app_base_flutter/models/home/response/room_list_response.dart';
import 'package:app_base_flutter/screens/vais_booking_room_handle/handle_booking_room.dart';
import 'package:app_base_flutter/services/navigations_servicces.dart';
import 'package:flutter/material.dart';

class RoomMeetingBookingDetailScreen extends StatefulWidget {
  final Room room;

  const RoomMeetingBookingDetailScreen({Key? key, required this.room})
      : super(key: key);

  @override
  _RoomMeetingBookingDetailScreenState createState() =>
      _RoomMeetingBookingDetailScreenState();
}

class _RoomMeetingBookingDetailScreenState
    extends State<RoomMeetingBookingDetailScreen> {
  final NavigationService navigationService = NavigationService();
  Room roomDetail = Room(
    name: "",
    description: "",
    status: "",
    openingHours: "",
    closingHours: "",
    isActive: false,
    bookedTimes: [],
    departments: [],
  );
  @override
  void initState() {
    super.initState();
    setState(() {
      roomDetail = widget.room;
    });
  }

  void funcCreateBookingRoomSuccess(Room newRoom) {
    if (newRoom != null) {
      setState(() {
        roomDetail = newRoom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isAvailable = roomDetail.status == "available";
    bool isActive = roomDetail.isActive;

    return Scaffold(
      appBar: AppBar(
        title:
            Text(roomDetail.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade200, Colors.blueAccent.shade100],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
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
                                roomDetail.name,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                roomDetail.description,
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
                            'Giờ mở cửa: ${roomDetail.openingHours}',
                            style: const TextStyle(
                              fontSize: 16,
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
                            'Giờ đóng cửa: ${roomDetail.closingHours}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
                              ? 'Phòng đang hoạt động'
                              : 'Phòng không hoạt động',
                          style: TextStyle(
                            fontSize: 16,
                            color: isActive ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (roomDetail.bookedTimes.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            'Thời gian đặt lịch:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 4),
                          ...roomDetail.bookedTimes.map((time) {
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
                                        fontSize: 16,
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
                    if (roomDetail.departments.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          const Text(
                            'Phòng ban đặt lịch:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 4),
                          ...roomDetail.departments.map((department) {
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
                                        fontSize: 16,
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Room roomDetailNavi = roomDetail;
                    navigationService.navigate(
                      context,
                      HandleBookingRoomScreen(
                        room: roomDetail,
                        funcCreateBookingRoom: funcCreateBookingRoomSuccess,
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Đặt Lịch'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

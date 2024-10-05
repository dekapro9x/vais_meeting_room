import 'package:app_base_flutter/common/log_utils.dart';
import 'package:app_base_flutter/models/home/response/room_list_response.dart';
import 'package:flutter/material.dart';
import 'package:app_base_flutter/configs/storages/app_prefs.dart';

class HandleBookingRoomScreen extends StatefulWidget {
  final Room room;
  const HandleBookingRoomScreen({Key? key, required this.room})
      : super(key: key);

  @override
  _HandleBookingRoomScreenState createState() =>
      _HandleBookingRoomScreenState();
}

class _HandleBookingRoomScreenState extends State<HandleBookingRoomScreen> {
  String? selectedDuration;
  String? selectedTimeSlot;
  final AppPrefStorage _appPref = AppPrefStorage();
  List<String> availableBookingTimeSlots = [];
  final List<String> durationsTimerSelect = [
    for (int i = 10; i <= 120; i += 10) '$i phút'
  ];

  @override
  void initState() {
    _appPref.init();
    super.initState();
    generateAvailableSlots();
  }

  void generateAvailableSlots() {
    List<String> availableSlots = [];
    final openingHour = parseTimeConvert(widget.room.openingHours);
    final closingHour = parseTimeConvert(widget.room.closingHours);

    DateTime current = openingHour;
    while (current.isBefore(closingHour)) {
      String formattedTime = formatTimeAMorPM(current);
      availableSlots.add(formattedTime);
      current = current.add(const Duration(hours: 1));
    }

    setState(() {
      availableBookingTimeSlots = availableSlots;
    });
  }

  //Có cái lỗi chuyển đổi thời gian 0h - 6h sáng lỗi (Fix sau)
  DateTime parseTimeConvert(String time) {
    final parts = time.split(" ");
    if (parts.length == 1) {
      parts.add("AM");
    }
    final timeParts = parts[0].split(":");
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final isPm = parts[1].toUpperCase() == "PM";
    final adjustedHour = isPm ? (hour % 12) + 12 : hour;
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, adjustedHour, minute);
  }

  String formatTimeAMorPM(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  void onPressConfirmBooking() async {
    // Kiểm tra xem người dùng đã chọn thời gian và thời lượng hay chưa
    if (selectedTimeSlot == null || selectedDuration == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content:
                const Text('Vui lòng chọn thời gian và thời lượng cuộc họp.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Đóng'),
              ),
            ],
          );
        },
      );
    } else {
      logWithColor(
        'Đặt lịch thành công cho phòng ${widget.room.name} vào lúc $selectedTimeSlot trong $selectedDuration',
        red,
      );

      // Sau khi đặt lịch thành công, thêm thời gian đã đặt vào bookedTimes => người dùng không thể đặt lại lịch vào thời gian này nữa.
      if (selectedTimeSlot != null) {
        await _appPref.init();
        setState(() {
          DateTime startTime = parseTimeConvert(selectedTimeSlot!);
          // Cộng thêm `selectedDuration` voà thời gian bắt đầu  _ thời gian booking họp:
          int durationMinutes = int.parse(selectedDuration!.split(' ')[0]);
          DateTime endTime = startTime.add(Duration(minutes: durationMinutes));
          String formattedEndTime = formatTimeAMorPM(endTime);
          widget.room.bookedTimes.add('$selectedTimeSlot - $formattedEndTime');
        });
        List<Room> listRoomChat = await _appPref.getListRoomMeetingManage();
        int roomIndex =
            listRoomChat.indexWhere((room) => room.name == widget.room.name);
        if (roomIndex != -1) {
          Room updatedRoom = Room(
            name: widget.room.name,
            description: widget.room.description,
            status: widget.room.status,
            openingHours: widget.room.openingHours,
            closingHours: widget.room.closingHours,
            isActive: widget.room.isActive,
            bookedTimes: widget.room.bookedTimes,
            departments: ["Phòng IT"],
          );
          listRoomChat[roomIndex] = updatedRoom;
        }
        List<Map<String, dynamic>> updatedRoomList =
            listRoomChat.map((room) => room.toJson()).toList();
        await _appPref.setListRoomMeetingManage(rooms: updatedRoomList);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: const Text('Cuộc họp đã được đặt lịch thành công!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Đóng'),
                ),
              ],
            );
          },
        );
      } else {
        logWithColor("Không có khung giờ nào được chọn!", red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.room.name, style: const TextStyle(color: Colors.white)),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.room.name,
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.room.description,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
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
                                    'Giờ mở cửa: ${widget.room.openingHours}',
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
                                    'Giờ đóng cửa: ${widget.room.closingHours}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (widget.room.bookedTimes.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Thời gian đã đặt:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...widget.room.bookedTimes.map((time) {
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
                            const SizedBox(height: 16),
                            if (widget.room.departments.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Phòng ban đã đặt:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...widget.room.departments.map((department) {
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
                    const SizedBox(height: 16),
                    const Text(
                      'Chọn thời lượng cuộc họp:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedDuration,
                      items: durationsTimerSelect
                          .map((duration) => DropdownMenuItem(
                                value: duration,
                                child: Text(duration),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDuration = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Khung giờ khả dụng:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    availableBookingTimeSlots.isNotEmpty
                        ? Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: availableBookingTimeSlots.map((slot) {
                              bool isBooked =
                                  widget.room.bookedTimes.contains(slot);
                              return ActionChip(
                                label: Text(slot),
                                onPressed: isBooked
                                    ? null
                                    : () {
                                        setState(() {
                                          selectedTimeSlot = slot;
                                        });
                                        logWithColor(
                                            "Chọn khung giờ: $slot", red);
                                      },
                                backgroundColor: isBooked
                                    ? Colors.grey.shade400
                                    : (selectedTimeSlot == slot)
                                        ? Colors.red
                                        : Colors.deepPurple.shade400,
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                              );
                            }).toList(),
                          )
                        : const Text(
                            'Không có khung giờ khả dụng.',
                            style: TextStyle(fontSize: 16, color: Colors.red),
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
                  onPressed: onPressConfirmBooking,
                  icon: const Icon(Icons.check),
                  label: const Text('Xác nhận đặt lịch'),
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

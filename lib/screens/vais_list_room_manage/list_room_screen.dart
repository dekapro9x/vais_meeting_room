import 'package:flutter/material.dart';

class ListRoomScreen extends StatefulWidget {
  const ListRoomScreen({Key? key}) : super(key: key);

  @override
  _ListRoomScreenState createState() => _ListRoomScreenState();
}

class _ListRoomScreenState extends State<ListRoomScreen> {
  final List<Map<String, dynamic>> _rooms = [
    {
      "name": "Phòng Họp A",
      "description": "Sức chứa 10 người",
      "status": "available",
      "openingHours": "08:00 AM",
      "closingHours": "06:00 PM",
      "isActive": true,
      "bookedTime": "Không có",
    },
    {
      "name": "Phòng Họp B",
      "description": "Sức chứa 20 người",
      "status": "booked",
      "openingHours": "09:00 AM",
      "closingHours": "05:00 PM",
      "isActive": true,
      "bookedTime": "10:00 AM - 11:00 AM",
    },
    {
      "name": "Phòng Họp C",
      "description": "Sức chứa 15 người",
      "status": "available",
      "openingHours": "08:00 AM",
      "closingHours": "05:00 PM",
      "isActive": true,
      "bookedTime": "Không có",
    },
    {
      "name": "Phòng Họp D",
      "description": "Sức chứa 8 người",
      "status": "booked",
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
      "isActive": true,
      "bookedTime": "Không có",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh Sách Phòng Họp',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade200, Colors.blueAccent.shade100],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _rooms.length,
            itemBuilder: (context, index) {
              return _buildRoomCard(_rooms[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    bool isAvailable = room["status"] == "available";
    bool isActive = room["isActive"] == true;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
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
                    color: isAvailable ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Icon(
                    isAvailable ? Icons.check : Icons.close,
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
                        room["name"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        room["description"],
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
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.deepPurple,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Giờ mở cửa: ${room["openingHours"]} - Giờ đóng cửa: ${room["closingHours"]}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  isActive ? Icons.check_circle : Icons.cancel,
                  color: isActive ? Colors.green : Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  isActive ? 'Phòng đang hoạt động' : 'Phòng không hoạt động',
                  style: TextStyle(
                    fontSize: 14,
                    color: isActive ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.event_note,
                  color: Colors.deepPurple,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Thời gian đặt lịch: ${room["bookedTime"]}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

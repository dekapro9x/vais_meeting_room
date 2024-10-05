import 'package:flutter/material.dart';
import 'package:app_base_flutter/common/log_utils.dart';

class VaisConfigRoomAdmin extends StatefulWidget {
  const VaisConfigRoomAdmin({Key? key}) : super(key: key);

  @override
  VaisConfigRoomAdminState createState() => VaisConfigRoomAdminState();
}

class VaisConfigRoomAdminState extends State<VaisConfigRoomAdmin> {
  @override
  void initState() {
    logWithColor('Admin cấu hình phòng họp', red);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget renderBodySetupRoomMeeting() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cấu hình phòng họp',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Giờ mở cửa:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Chọn giờ'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Giờ đóng cửa:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Chọn giờ'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.save),
              label: const Text('Lưu cấu hình'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cấu Hình Phòng Họp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: renderBodySetupRoomMeeting(),
      ),
    );
  }
}

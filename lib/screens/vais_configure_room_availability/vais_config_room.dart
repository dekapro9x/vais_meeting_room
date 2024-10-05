import 'package:app_base_flutter/common/log_utils.dart';
import 'package:app_base_flutter/configs/storages/app_prefs.dart';
import 'package:app_base_flutter/models/home/response/room_list_response.dart';
import 'package:flutter/material.dart';

class VaisConfigRoomAdmin extends StatefulWidget {
  const VaisConfigRoomAdmin({Key? key}) : super(key: key);

  @override
  VaisConfigRoomAdminState createState() => VaisConfigRoomAdminState();
}

class VaisConfigRoomAdminState extends State<VaisConfigRoomAdmin> {
  final TextEditingController nameRoomController = TextEditingController();
  final TextEditingController descriptionRoomController =
      TextEditingController();
  final AppPrefStorage _appPref = AppPrefStorage();
  TimeOfDay? openingTimeSelect;
  TimeOfDay? closingTimeSelect;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameRoomController.dispose();
    descriptionRoomController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isOpeningTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isOpeningTime) {
          openingTimeSelect = pickedTime;
        } else {
          closingTimeSelect = pickedTime;
        }
      });
    }
  }

  void onPressSaveConfiguration(BuildContext context) async {
    String name = nameRoomController.text;
    String description = descriptionRoomController.text;
    String? openingTime =
        openingTimeSelect != null ? openingTimeSelect!.format(context) : null;
    String? closingTime =
        closingTimeSelect != null ? closingTimeSelect!.format(context) : null;
    if (name.isEmpty ||
        description.isEmpty ||
        openingTime == null ||
        closingTime == null) {
      showValidationDialogError(context);
    } else {
      logWithColor(
          'Khởi tạo phòng hợp mới trong danh sách: Tên phòng: $name, Mô tả: $description, Giờ mở cửa: $openingTime, Giờ đóng cửa: $closingTime',
          red);
      await _appPref.init();
      List<Room> listRoomChat = await _appPref.getListRoomMeetingManage();
      // Tạo đối tượng Room mới để thêm vào danh sách phòng họp:
      Room newRoom = Room(
        name: name,
        description: description,
        status: "available",
        openingHours: openingTime,
        closingHours: closingTime,
        isActive: false,
        bookedTimes: [],
        departments: [],
      );
      // Thêm phòng họp mới vào danh sách và chuyển đổi thành JSON để lưu trữ:=> Chỗ này thêm vào danh sách phòng họp main.
      listRoomChat.add(newRoom);
      logWithColor(
          'Danh sách phòng họp sau khi thêm mới: $listRoomChat', green);
      List<Map<String, dynamic>> updatedRoomList =
          listRoomChat.map((room) => room.toJson()).toList();
      await _appPref.setListRoomMeetingManage(rooms: updatedRoomList);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thành Công'),
            content: const Text('Phòng họp mới đã được khởi tạo thành công.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Đóng'),
              ),
            ],
          );
        },
      );
      nameRoomController.clear();
      descriptionRoomController.clear();
      setState(() {
        openingTimeSelect = null;
        closingTimeSelect = null;
      });
    }
  }

  void showValidationDialogError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thông tin chưa đầy đủ'),
          content: const Text(
              'Vui lòng kiểm tra lại thông tin, không được để trống.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
                    'Thêm phòng họp mới',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Tên phòng họp',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameRoomController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Mô tả phòng họp',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descriptionRoomController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Giờ mở cửa',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _selectTime(context, true);
                        },
                        child: Text(
                          openingTimeSelect != null
                              ? openingTimeSelect!.format(context)
                              : 'Chọn giờ',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Giờ đóng cửa',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _selectTime(context, false);
                        },
                        child: Text(
                          closingTimeSelect != null
                              ? closingTimeSelect!.format(context)
                              : 'Chọn giờ',
                        ),
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
              onPressed: () {
                onPressSaveConfiguration(context);
              },
              icon: const Icon(Icons.save),
              label: const Text('Tạo phòng họp mới'),
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
        title: const Text('Thêm Phòng Họp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: renderBodySetupRoomMeeting(),
      ),
    );
  }
}

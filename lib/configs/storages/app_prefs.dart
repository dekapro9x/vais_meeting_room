import 'dart:convert';
import 'package:app_base_flutter/configs/global_constants.dart';
import 'package:app_base_flutter/configs/storages/base_prefs.dart';
import 'package:app_base_flutter/models/home/response/room_list_response.dart';

class AppPrefStorage extends BasePrefsStorage {
  static Future<AppPrefStorage> instance() async {
    final _appPref = AppPrefStorage();
    await _appPref.init();
    return _appPref;
  }

  //Lưu lại danh sách phòng họp được quản lý (Có thể thêm bớt, sửa xoá từ admin):
  Future<void> setListRoomMeetingManage(
      {required List<Map<String, dynamic>> rooms}) async {
    String jsonString = jsonEncode(rooms);
    await setValueForKey(GlobalConstants.listRoomMeetingManage, jsonString);
  }

  //Lấy danh sách phòng họp được quản lý:
  Future<List<Room>> getListRoomMeetingManage() async {
    String? jsonString =
        await getValueForKey(GlobalConstants.listRoomMeetingManage);
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((json) => Room.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  //Gán danh sách phòng họp đã được booking của tôi (Thêm vào danh sách phòng mới):
  Future<void> setNewRoomMeetingBookingSuccess(
      {required List<Map<String, dynamic>> rooms}) async {
    String jsonString = jsonEncode(rooms);
    await setValueForKey(GlobalConstants.listRoomBookingSuccess, jsonString);
  }

  //Lấy danh sách phòng họp đã được booking của tôi:
  Future<List<Room>> getListRoomMeetingBookingSuccess() async {
    String? jsonString =
        await getValueForKey(GlobalConstants.listRoomBookingSuccess);
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((json) => Room.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveActionsAcceptPolicyUseApp({required bool isAccept}) async {
    await setValueForKey(GlobalConstants.isAcceptPolicy, isAccept);
  }

  Future<bool> hasLoggedIn() async {
    return false;
  }

  Future<String> getToken() async {
    await getValueForKey(GlobalConstants.TokenUserLogin);
    return 'USER_TOKEN';
  }

  Future<void> saveSkipOnboard({required bool isSkip}) async {
    await setValueForKey(GlobalConstants.kSkipOnboard, isSkip);
  }

  Future<String?> getLanguage() async {
    final _language = this.getValueForKey<String?>(GlobalConstants.kLanguage);
    return _language;
  }

  Future<void> savelanguage({required String languageCode}) async {
    await this.setValueForKey(GlobalConstants.kLanguage, languageCode);
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Hàm ghi log với màu sắc
void logWithColor(String message, String color) {
  if (kReleaseMode) {
    print('Môi trường release product');
  } else {
    print('BeoTranDev:$color$message\x1B[0m');
  }
}

//Hàm ghi log path file:
void logWithColorYouCanOpenPathFile(String pathFile) {
  if (kReleaseMode) {
    print('Môi trường release product'); 
  } else {
    print('$brightGreen[Open Markdown File - BeoTranDev](file://$pathFile)'); 
  }
}

// Hàm ghi thông tin XFile
void logXFileInfo(String title, XFile file) async {
  const yellow = '\x1B[33m';
  const reset = '\x1B[0m'; 
  const String red = '\x1B[31m';
  debugPrint('$yellow$title Ảnh Xfile => $red Path: ${file.path}$reset');
  debugPrint('$yellow$title Ảnh Xfile Name: $red${file.name}$reset');
  debugPrint('$yellow$title Ảnh Xfile Length: $red${await file.length()} bytes$reset');
  debugPrint('$yellow$title Ảnh Xfile MIME Type: $red${file.mimeType ?? 'Unknown'}$reset');
}

// Hiển thị dialog log
void showDialogValueDebug(BuildContext context, dynamic object) {
  String jsonString = jsonEncode(object);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Chi tiết Object:'),
        content: SingleChildScrollView(
          child: Text(
            jsonString,
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    },
  );
}

// Hiển thị thông tin object không cần context
void logWithDialogValueDebugNotContext(dynamic object) {
  if (kReleaseMode) {
    logWithColor("Môi trường release product - không hiển thị log", red);
  } else {
    String jsonString = jsonEncode(object);
    BuildContext? context = Navigator.of(NavigatorState().context).context;
    if (context != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Chi tiết Object:'),
            content: SingleChildScrollView(
              child: Text(
                jsonString,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          );
        },
      );
    } else {
      debugPrint("Error: No valid context available for showing dialog.");
    }
  }
}

// Hiển thị thông tin object với tùy chọn sao chép JSON vào clipboard
void logWithDialogValueDebugCopyJSON(dynamic object) {
  if (kReleaseMode) {
    logWithColor("Môi trường release product - không hiển thị log", red);
  } else {
    String jsonString = jsonEncode(object);
    BuildContext? context = Navigator.of(NavigatorState().context).context;
    if (context != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Chi tiết Object:'),
            content: SingleChildScrollView(
              child: Text(
                jsonString,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: jsonString));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã sao chép vào clipboard!')),
                  );
                },
                child: const Text('Sao chép'),
              ),
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
    } else {
      debugPrint("Error: No valid context available for showing dialog.");
    }
  }
}

// Mã màu ANSI
const String red = '\x1B[31m';
const String green = '\x1B[32m';
const String yellow = '\x1B[33m';
const String blue = '\x1B[34m';
const String magenta = '\x1B[35m';
const String cyan = '\x1B[36m';
const String white = '\x1B[37m';
const String reset = '\x1B[0m';
const String brightRed = '\x1B[91m'; // Màu đỏ sáng
const String brightGreen = '\x1B[92m'; // Màu xanh lá cây sáng
const String brightYellow = '\x1B[93m'; // Màu vàng sáng
const String brightBlue = '\x1B[94m'; // Màu xanh dương sáng
const String brightMagenta = '\x1B[95m'; // Màu hồng sáng
const String brightCyan = '\x1B[96m'; // Màu xanh ngọc sáng
const String brightWhite = '\x1B[97m';   // Màu trắng sáng

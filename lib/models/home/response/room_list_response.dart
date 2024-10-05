class Room {
  final String name;
  final String description;
  final String status;
  final String openingHours;
  final String closingHours;
  final bool isActive;
  final String bookedTime;

  Room({
    required this.name,
    required this.description,
    required this.status,
    required this.openingHours,
    required this.closingHours,
    required this.isActive,
    required this.bookedTime,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      openingHours: json['openingHours'] as String,
      closingHours: json['closingHours'] as String,
      isActive: json['isActive'] as bool,
      bookedTime: json['bookedTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'status': status,
      'openingHours': openingHours,
      'closingHours': closingHours,
      'isActive': isActive,
      'bookedTime': bookedTime,
    };
  }
}

class RoomListResponse {
  final List<Room> rooms;

  RoomListResponse({required this.rooms});

  factory RoomListResponse.fromJson(List<dynamic> jsonList) {
    List<Room> roomList = jsonList.map((json) => Room.fromJson(json)).toList();
    return RoomListResponse(rooms: roomList);
  }

  List<Map<String, dynamic>> toJson() {
    return rooms.map((room) => room.toJson()).toList();
  }
}

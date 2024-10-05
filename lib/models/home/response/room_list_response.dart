class Room {
  final String name; // Tên phòng họp
  final String description; // Mô tả phòng họp
  final String status; // Trạng thái phòng họp
  final String openingHours; // Giờ mở cửa
  final String closingHours; // Giờ đóng cửa
  final bool isActive; // Trạng thái hoạt động của phòng họp
  final List<String> bookedTimes; // Thời gian đã đặt của phòng họp
  final List<String> departments; // Danh sách phòng ban đặt lịch

  Room({
    required this.name,
    required this.description,
    required this.status,
    required this.openingHours,
    required this.closingHours,
    required this.isActive,
    required this.bookedTimes,
    required this.departments,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      openingHours: json['openingHours'] as String,
      closingHours: json['closingHours'] as String,
      isActive: json['isActive'] as bool,
      bookedTimes: List<String>.from(json['bookedTimes'] ?? []),
      departments: List<String>.from(json['departments'] ?? []),
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
      'bookedTimes': bookedTimes,
      'departments': departments,
    };
  }
}

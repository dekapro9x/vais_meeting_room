class Room {
  final String name;
  final String description;
  final String status;
  final String openingHours;
  final String closingHours;
  final bool isActive;
  final List<String> bookedTimes;

  Room({
    required this.name,
    required this.description,
    required this.status,
    required this.openingHours,
    required this.closingHours,
    required this.isActive,
    required this.bookedTimes,
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
    };
  }
}

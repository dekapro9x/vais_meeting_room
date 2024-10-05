class Room {
  final String name;
  final String description;
  final String status;

  Room({
    required this.name,
    required this.description,
    required this.status,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'status': status,
    };
  }
}

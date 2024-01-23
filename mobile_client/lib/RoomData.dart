import 'dart:convert';

class Person {
  final String title;
  final String name;
  final String surname;

  Person({required this.title, required this.name, required this.surname});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      title: json['title'],
      name: json['name'],
      surname: json['surname'],
    );
  }
}

class RoomData {
  final int humidity;
  final List<Person> occupants;
  final String purpose;
  final int seats;
  final double temperature;

  RoomData({
    required this.humidity,
    required this.occupants,
    required this.purpose,
    required this.seats,
    required this.temperature,
  });

  @override
  String toString() {
    String occupantsString = occupants
        .map((occupant) =>
            '${occupant.title} ${occupant.name} ${occupant.surname}')
        .join(', ');
    return 'RoomData{humidity: $humidity, occupants: [$occupantsString], purpose: $purpose, temperature: $temperature}';
  }

  factory RoomData.fromJson(Map<String, dynamic> json) {
    List<dynamic> occupantsList =
        json['occupants'] ?? []; // Check if occupants field exists
    List<Person> occupants = occupantsList.isNotEmpty
        ? occupantsList
            .map((occupant) => Person.fromJson(
                Map<String, dynamic>.from(jsonDecode(occupant))))
            .toList()
            .cast<Person>()
        : [];

    return RoomData(
      humidity: json['humidity'],
      occupants: occupants,
      seats: json['seats'] ?? 0,
      // Default value for rooms without occupants
      purpose: json['purpose'],
      temperature: json['temperature'],
    );
  }
}

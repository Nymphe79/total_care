// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Appointment {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String memberId;
  final String name;

  Appointment(
      {required this.id,
      required this.title,
      required this.name,
      this.description = '',
      required this.date,
      required this.time,
      required this.memberId});

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'time': time,
      'memberId': memberId,
      'name': name,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
     id: map['_id'] ?? '',
     title: map['title'] ?? '',
     description: map['description'] ?? '',
    date: DateTime.now(),
     time: map['time'] ?? '',
     memberId: map['memberId'] ?? '',
     name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) => Appointment.fromMap(json.decode(source) as Map<String, dynamic>);
}

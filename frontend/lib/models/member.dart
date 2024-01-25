// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Member {
  final String id;
  final String name;
  final String email;
  final int mobile;
  final String password;
  final String address;
  final String type;
  final String token;
  // final List<String> image;
  String image;

  Member(
      {required this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.mobile,
      required this.password,
      required this.type,
      required this.token,
      required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'image': image,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
        id: map['_id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        mobile: map['mobile'] ?? '',
        password: map['password'] ?? '',
        address: map['address'] ?? '',
        type: map['type'] ?? '',
        token: map['token'] ?? '',
        // image: List<String>.from(map['image'] ?? ''));
        image: map['image'] ?? '' );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) => Member.fromMap(json.decode(source));

  Member copyWith({
    String? id,
    String? name,
    String? email,
    int? mobile,
    String? password,
    String? address,
    String? type,
    String? token,
    // List<String>? image,
    String? image,
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      // image: image ?? this.image,
      image: image ?? this.image,
    );
  }
}

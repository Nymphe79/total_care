
import 'dart:convert';

class Service {
  final String id;
  final String serviceName;
  final double price;
  final List<String> image;


  Service(
      {required this.id,
      required this.serviceName,
      required this.price,
      required this.image,
     
      });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serviceName': serviceName,
      'price': price,
      'image': image,
    
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['_id'] ,
  
      serviceName: map['serviceName'] ,
      price: map['price']?.toDouble() ?? 0.0,
      image: List<String>.from(map['image'] ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source));
}

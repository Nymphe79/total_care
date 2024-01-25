// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Staff {
  final String id;
  final String name;
  final String profession;
  
  final int mobile;
 
  final String email;
  final List<String> image;
 
  final String type;

  Staff({
    required this.id,
    
    required this.type,
 
    required this.name,
    required this.image,
    required this.email,
    required this.profession,
   
    required this.mobile,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'profession': profession,
      
      'mobile': mobile,
      
      'email': email,
      'image': image,
    
      'type': type,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
        id: map['_id']?? '',
        
        type: map['type']?? '',
        
        name: map['name']?? '',
        image: List<String>.from(map['image']?? ''),
        email: map['email']?? '',
        profession: map['profession']?? '',
        
        mobile: map['mobile'] ?? '',);
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) =>
      Staff.fromMap(json.decode(source) as Map<String, dynamic>);
}

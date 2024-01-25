import 'package:flutter/material.dart';
import 'package:totalcare/models/member.dart';

class MemberProvider extends ChangeNotifier {
  Member _member = Member(
      id: '',
      name: '',
      email: '',
      address: '',
      mobile: 0,
      password: '',
      type: '',
      token: '',
      // image: [],
      image: ''
    
      );

  Member get member => _member;

  void setMember(String member) {
    _member = Member.fromJson(member);

    notifyListeners();
  }

  //  for updating memmberprovider
  void setMemProvider(Member member) {
    _member = member;
    notifyListeners();
  }
}

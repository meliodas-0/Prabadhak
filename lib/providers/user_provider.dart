import 'package:flutter/material.dart';
import 'package:prabandhak/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  UserProvider({required User user}) : _user = user;

  changeUser(User user) {
    _user = user;
    notifyListeners();
  }

  User get user => _user;
}

import 'package:dbu_gym/models/gym_user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  GymUser? _user;

  void setUser(GymUser user) {
    _user = user;
    notifyListeners();
  }

  GymUser? get user => _user;
}

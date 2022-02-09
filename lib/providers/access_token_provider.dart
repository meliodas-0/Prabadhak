import 'package:flutter/material.dart';

class AccessTokenProvider extends ChangeNotifier {
  String? _accessToken;

  AccessTokenProvider({String? accessToken}) : _accessToken = accessToken;

  changeAccessToken(String accessToken) {
    _accessToken = _accessToken;
    notifyListeners();
  }

  String get accessToken => _accessToken!;
}

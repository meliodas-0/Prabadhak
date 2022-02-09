import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:prabandhak/Screens/welcome_screen.dart';
import 'package:prabandhak/helpers/shared_preference.dart';
import 'package:prabandhak/models/user.dart';
import 'package:prabandhak/providers/user_provider.dart';
import 'package:provider/provider.dart';

//Method to set user with access token
setUser(BuildContext context, String accessToken) async {
  // String userData = utf8.decode(base64Decode(accessToken.split('.')[1]));
  //
  var t = JwtDecoder.decode(accessToken);
  print(t.keys);
  var userData = jsonEncode(t);
  User user = User.fromJson(jsonDecode(userData));
  setStringIntoCache(USER_MAP, userData);
  //
  Provider.of<UserProvider>(context, listen: false).changeUser(user);
}

//This function makes the Widget start of the Stack
makeThisPageStartOfTheStack(BuildContext context, Widget path) {
  Navigator.popUntil(context, (route) => route.isFirst);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => path,
    ),
  );
}

//Logout function
logout(BuildContext context) {
  removeStringFromCache(ACCESS_TOKEN);
  removeStringFromCache(USER_MAP);
  makeThisPageStartOfTheStack(context, const WelcomeScreen());
}

//date time formatter
String formatDateTime(DateTime dateTime) =>
    DateFormat(DateFormat.ABBR_MONTH_DAY).format(dateTime);

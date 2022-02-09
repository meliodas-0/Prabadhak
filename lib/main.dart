import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prabandhak/Screens/bottom_navigation_page.dart';
import 'package:prabandhak/Screens/welcome_screen.dart';
import 'package:prabandhak/helpers/constants.dart';
import 'package:prabandhak/helpers/shared_preference.dart';
import 'package:prabandhak/models/user.dart';
import 'package:prabandhak/providers/access_token_provider.dart';
import 'package:prabandhak/providers/user_provider.dart';
import 'package:prabandhak/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Prabandhak());
}

class Prabandhak extends StatelessWidget {
  const Prabandhak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(
            user: User(name: 'name', uID: 'uid', username: 'username'),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AccessTokenProvider(),
        ),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        child: MaterialApp(
          home: const StarterScreen(),
          darkTheme: AppTheme.dark(),
          theme: AppTheme.light(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

class StarterScreen extends StatelessWidget {
  const StarterScreen({Key? key}) : super(key: key);

  Future<bool> getUser(BuildContext context) async {
    String userMap = await getStringFromCache(USER_MAP);
    String accessToken = await getStringFromCache(ACCESS_TOKEN);
    if (userMap.isEmpty || accessToken.isEmpty) {
      return Future.value(false);
    }
    //Setting access token in provider
    Provider.of<AccessTokenProvider>(context, listen: false)
        .changeAccessToken(accessToken);

    //Setting user Data in provider
    Map<String, dynamic> userData = jsonDecode(userMap);

    Provider.of<UserProvider>(context, listen: false)
        .changeUser(User.fromJson(userData));
    print(accessToken);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    brightness = MediaQuery.of(context).platformBrightness;
    return FutureBuilder<bool>(
      future: getUser(context),
      builder: (context, snapshot) => snapshot.hasData
          ? Center(
              child: (snapshot.data ?? false)
                  ? const BottomNavigationPage()
                  : const WelcomeScreen(),
            )
          : const CircularProgressIndicator(),
    );
  }
}

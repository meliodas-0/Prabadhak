import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prabandhak/Screens/welcome_screen.dart';
import 'package:prabandhak/theme.dart';

void main() {
  runApp(const Prabandhak());
}

class Prabandhak extends StatelessWidget {
  const Prabandhak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: MaterialApp(
        home: const StarterScreen(),
        darkTheme: AppTheme.dark(),
        theme: AppTheme.light(),
      ),
    );
  }
}

class StarterScreen extends StatelessWidget {
  const StarterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: WelcomeScreen(),
    );
  }
}

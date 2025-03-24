import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopsmart1/pages/start_page.dart';
import 'home_page.dart';
import 'login_page.dart';

class AuthCheck extends StatefulWidget {
  final SharedPreferences prefs;
  const AuthCheck({super.key, required this.prefs});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool? isFirstTime;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  Future<void> checkFirstTime() async {
    bool firstTime = widget.prefs.getBool('isFirstTime') ?? true;
    setState(() {
      isFirstTime = firstTime;
    });

    if (firstTime) {
      await widget.prefs.setBool('isFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTime == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (isFirstTime!) {
      return const StartPage();
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final User? user = snapshot.data;
        return user == null ? LoginPage() : HomePage();
      },
    );
  }
}


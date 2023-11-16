import 'package:flutter/material.dart';
import 'package:ldd_app/components/circular_progress.dart';
import 'package:ldd_app/components/global_key.dart';
import 'package:ldd_app/screens/home.dart';
import 'package:ldd_app/screens/login.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkIfLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularLoader();
          } else {
            if (snapshot.data != null && snapshot.data!) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            } 
          }
      },
    );
  }

  Future<bool> _checkIfLoggedIn() async {
    String? token = await storage.read(key: 'token');
    return token != null;
  }
}

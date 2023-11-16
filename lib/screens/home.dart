import "package:flutter/material.dart";
import 'package:ldd_app/components/global_key.dart';

import 'package:ldd_app/screens/login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logout(BuildContext context) async {
    await storage.delete(key: 'token');
    navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
      builder: (_) => const LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Do you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            logout(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: const Center(
          child: Text("Welcome To my app."),
        ));
  }
}

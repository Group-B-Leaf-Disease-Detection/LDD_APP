import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ldd_app/screens/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String? serverStatus;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _checkServerStatus();
  }

  Future<void> _checkServerStatus() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.smartkrishi.me/status/'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 'Server is running') {
          if (mounted) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const CheckAuth(),
            ));
          }
        } else {
          setState(() {
            serverStatus = 'Server is not running';
          });
        }
      } else {
        setState(() {
          serverStatus = 'Failed to connect to server';
        });
      }
    } catch (e) {
      setState(() {
        serverStatus = 'Error: Check your internet connection.';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.white],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipOval(
              child: Image.asset(
            "assets/images/background.jpg",
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          )),
          const SizedBox(height: 20),
          const Text(
            "Smart Krishi",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 70),
          if (serverStatus == null)
            const CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          if (serverStatus != null)
            Text(
              serverStatus!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    ));
  }
}

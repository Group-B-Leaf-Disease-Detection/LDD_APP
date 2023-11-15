import 'package:flutter/material.dart';
import 'package:ldd_app/components/button.dart';
import 'package:ldd_app/components/text_field.dart';
import 'package:ldd_app/screens/home.dart';
import 'package:ldd_app/components/global_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    final response = await http.post(
      Uri.parse('https://api.smartkrishi.me/login/'),
      body: {'username': username, 'password': password},
    );
    final responseJson = jsonDecode(response.body);
    if (responseJson['token'] != null) {
      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
      builder: (_) => const HomeScreen(),
    ));
    } else {
      scaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(content: Text('Login failed. Please try again.')),
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.green, Colors.white],
            ),
          ),
          child: Center(
            child: Column(children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 25),
              Text(
                "Please, Login to continue.",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              InputTextField(
                controller: usernameController,
                hintText: "Username",
                obscureText: false,
              ),
              const SizedBox(height: 25),
              InputTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blue[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Button(
                onTap: () => signUserIn(context),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?",
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(width: 4),
                  Text('Register now',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

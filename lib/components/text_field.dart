import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final bool obscureText;
  final String errorMessage;

  const InputTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.errorMessage,

    });

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: hintText,
                    hintStyle: TextStyle(color:Colors.grey.shade500),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return errorMessage;
                    }
                    return null;
                  },
                ),
              );
  }
}
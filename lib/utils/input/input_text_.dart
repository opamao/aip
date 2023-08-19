import 'package:flutter/material.dart';

class InputText_ extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool obscureText;

  const InputText_({
    Key? key,
    required this.controller,
    this.keyboardType,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.blueGrey
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

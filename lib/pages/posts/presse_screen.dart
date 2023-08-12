import 'package:aip/utils/colors.dart';
import 'package:flutter/material.dart';

class PresseScreen extends StatefulWidget {
  const PresseScreen({super.key});

  @override
  State<PresseScreen> createState() => _PresseScreenState();
}

class _PresseScreenState extends State<PresseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: oranges.withOpacity(.2),
        automaticallyImplyLeading: false,
        title: const Text("Presses"),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

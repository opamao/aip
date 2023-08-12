import 'package:aip/utils/colors.dart';
import 'package:flutter/material.dart';

class KiosquesScreen extends StatefulWidget {
  const KiosquesScreen({super.key});

  @override
  State<KiosquesScreen> createState() => _KiosquesScreenState();
}

class _KiosquesScreenState extends State<KiosquesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: oranges.withOpacity(.2),
        automaticallyImplyLeading: false,
        title: const Text("Kiosques"),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

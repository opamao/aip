import 'package:aip/utils/colors.dart';
import 'package:flutter/material.dart';

class MediasScreen extends StatefulWidget {
  const MediasScreen({super.key});

  @override
  State<MediasScreen> createState() => _MediasScreenState();
}

class _MediasScreenState extends State<MediasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: oranges.withOpacity(.2),
        automaticallyImplyLeading: false,
        title: const Text("Medias"),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

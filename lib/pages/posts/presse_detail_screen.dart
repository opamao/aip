import 'dart:convert';

import 'package:aip/pages/posts/presse_model.dart';
import 'package:aip/utils/colors.dart';
import 'package:aip/utils/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PresseDetailScreen extends StatefulWidget {
  final Presses presse;

  const PresseDetailScreen({super.key, required this.presse});

  @override
  State<PresseDetailScreen> createState() => _PresseDetailScreenState();
}

class _PresseDetailScreenState extends State<PresseDetailScreen> {
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    print("ICI ${widget.presse.lLinks!.wpFeaturedmedia!.single.href!}");
    var url = Uri.parse(widget.presse.lLinks!.wpFeaturedmedia!.single.href!);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      final imageUrl = jsonResponse['source_url'] as String;
      setState(() {
        this.imageUrl = imageUrl;
      });
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: oranges.withOpacity(.2),
        title: Text(widget.presse.title!.rendered!),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                const Gap(10),
                Text(
                  "Publié le ${formatDate(widget.presse.dateGmt!)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                const Gap(10),
                SizedBox(
                  child: HtmlWidget(
                    widget.presse.title!.rendered!,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Gap(15),
                SizedBox(
                  child: HtmlWidget(
                    widget.presse.content!.rendered!,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

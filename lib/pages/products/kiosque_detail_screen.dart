import 'dart:convert';

import 'package:aip/pages/products/kisoque_model_.dart';
import 'package:aip/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class KiosqueDetailScreen extends StatefulWidget {
  final Kiosques_ kiosque;

  const KiosqueDetailScreen({super.key, required this.kiosque});

  @override
  State<KiosqueDetailScreen> createState() => _KiosqueDetailScreenState();
}

class _KiosqueDetailScreenState extends State<KiosqueDetailScreen> {
  // String imageUrl = "";

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // Future<void> fetchData() async {
  //   var url = Uri.parse(widget.kiosque.lLinks!.wpFeaturedmedia!.single.href!);
  //
  //   final response = await http.get(url);
  //
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
  //     final imageUrl = jsonResponse['source_url'] as String;
  //     setState(() {
  //       this.imageUrl = imageUrl;
  //     });
  //   } else {
  //     throw Exception("Une erreur s'est produite");
  //   }
  // }

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
        title: Text(widget.kiosque.title!.rendered!),
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
                    widget
                        .kiosque.eEmbedded!.wpFeaturedmedia!.single.sourceUrl!,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 300,
                  ),
                ),
                const Gap(10),
                Text(
                  "Publié le ${formatDate(widget.kiosque.dateGmt!)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                const Gap(10),
                SizedBox(
                  child: HtmlWidget(
                    widget.kiosque.title!.rendered!,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Gap(15),
                SizedBox(
                  child: HtmlWidget(
                    widget.kiosque.content!.rendered!,
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

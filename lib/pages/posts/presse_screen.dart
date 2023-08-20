import 'dart:convert';

import 'package:aip/pages/posts/presse_detail_screen.dart';
import 'package:aip/pages/posts/presse_model.dart';
import 'package:aip/utils/colors.dart';
import 'package:aip/utils/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class PresseScreen extends StatefulWidget {
  const PresseScreen({super.key});

  @override
  State<PresseScreen> createState() => _PresseScreenState();
}

class _PresseScreenState extends State<PresseScreen> {
  var recherche = TextEditingController();

  Future<List<Presses>> fetchData() async {
    var url = Uri.parse(Constance.posts);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Presses.fromJson(data)).toList();
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: oranges.withOpacity(.2),
        automaticallyImplyLeading: false,
        title: const Text("Presses"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<Presses>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PresseDetailScreen(
                                  presse: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      "assets/images/logo.png",
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: HtmlWidget(
                                    snapshot.data![index].title!.rendered!,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const Gap(15),
                                SizedBox(
                                  child: HtmlWidget(
                                    snapshot.data![index].excerpt!.rendered!,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return Text(snapshot.error.toString());
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

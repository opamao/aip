import 'dart:convert';
import 'dart:io';

import 'package:aip/pages/posts/presse_detail_screen.dart';
import 'package:aip/pages/posts/presse_model_.dart';
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

  Future<List<Presses_>> fetchData() async {
    String? url = Constance.posts;

    var isRedirect = true;

    //final response = await http.get(url);

    while (isRedirect) {
      final client = http.Client();
      final request = http.Request('GET', Uri.parse(url!))
        ..followRedirects = false
        ..headers['cookie'] = 'security=true';
      print(request.headers);
      final response = await client.send(request);

      if (response.statusCode == HttpStatus.movedTemporarily) {
        isRedirect = response.isRedirect;
        url = response.headers['location'];
        // final receivedCookies = response.headers['set-cookie'];
      } else if (response.statusCode == HttpStatus.ok) {
        final String responseBody = await response.stream.bytesToString();
        final List<dynamic> jsonResponse = json.decode(responseBody);
        return jsonResponse.map((data) => Presses_.fromJson(data)).toList();
      } else {
        throw Exception("An error occurred");
      }
    }

    // if (response.statusCode == 200) {
    //   final List<dynamic> jsonResponse = json.decode(response.body);
    //   return jsonResponse.map((data) => Presses.fromJson(data)).toList();
    // } else {
    //   throw Exception("Une erreur s'est produite");
    // }

    throw Exception("No valid response received");
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
          child: FutureBuilder<List<Presses_>>(
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
                                    child: Image.network(
                                      snapshot
                                              .data![index]
                                              .eEmbedded!
                                              .wpFeaturedmedia!
                                              .first
                                              .sourceUrl ??
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

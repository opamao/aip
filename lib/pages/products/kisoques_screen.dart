import 'dart:convert';

import 'package:aip/pages/products/kiosque_detail_screen.dart';
import 'package:aip/pages/products/kisoque_model.dart';
import 'package:aip/utils/colors.dart';
import 'package:aip/utils/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;

class KiosquesScreen extends StatefulWidget {
  const KiosquesScreen({super.key});

  @override
  State<KiosquesScreen> createState() => _KiosquesScreenState();
}

class _KiosquesScreenState extends State<KiosquesScreen> {
  Future<List<Kiosques>> fetchData() async {
    var url = Uri.parse(Constance.products);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Kiosques.fromJson(data)).toList();
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
        title: const Text("Kiosques"),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Kiosques>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Pass de media disponible.'),
              );
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KiosqueDetailScreen(
                            kiosque: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/logos.png",
                              fit: BoxFit.contain,
                              width: double.infinity,
                              // height: 200,
                            ),
                            Expanded(
                              child: HtmlWidget(
                                snapshot.data![index].title!.rendered!,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

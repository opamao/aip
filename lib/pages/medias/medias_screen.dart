import 'dart:convert';

import 'package:aip/pages/medias/medias_model.dart';
import 'package:aip/utils/colors.dart';
import 'package:aip/utils/constance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MediasScreen extends StatefulWidget {
  const MediasScreen({super.key});

  @override
  State<MediasScreen> createState() => _MediasScreenState();
}

class _MediasScreenState extends State<MediasScreen> {
  var recherche = TextEditingController();

  Future<List<Medias>> fetchData() async {
    var url = Uri.parse(Constance.medias);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Medias.fromJson(data)).toList();
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
        title: const Text("Medias"),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Medias>>(
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
                  final imageUrl = snapshot.data![index].sourceUrl!;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ZoomedImageScreen(imageUrl: imageUrl),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: Image.network(
                          snapshot.data![index].sourceUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          // height: 200,
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

class ZoomedImageScreen extends StatelessWidget {
  final String imageUrl;

  const ZoomedImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

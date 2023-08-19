import 'package:aip/utils/colors.dart';
import 'package:aip/utils/input/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';

class PresseScreen extends StatefulWidget {
  const PresseScreen({super.key});

  @override
  State<PresseScreen> createState() => _PresseScreenState();
}

class _PresseScreenState extends State<PresseScreen> {
  var recherche = TextEditingController();

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
          child: Column(
            children: [
              InputText_(
                keyboardType: TextInputType.text,
                controller: recherche,
                hintText: "Rechercher",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.blueGrey,
                ),
              ),
              const Gap(20),
              Card(
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
                            "https://www.aip.ci/wp-content/uploads/2023/08/e1552fa5679d008e7e0027cd61506020ca7b05d2.jpg",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                      ),
                      const HtmlWidget(
                        "Côte d&rsquo;Ivoire &#8211; AIP/ Le FEEF exhorte les femmes de Dabou à la sororité pour améliorer leur quotidien",
                      ),
                       const HtmlWidget(
                         "<p>Dabou, 14 août 2023 (AIP)- Le Forum de l&#8217;emploi et de l&rsquo;entrepreneuriat féminin (FEEF) a exhorté samedi 12 août à la pouponnière de Dabou, à travers un panel, les femmes à la sororité et à travailler main dans la main. C&rsquo;était lors de la 3e étape de la 10è édition<span class=\"more-link\"><a href=\"https://www.aip.ci/cote-divoire-aip-le-feef-exhorte-les-femmes-de-dabou-a-la-sororite-pour-ameliorer-leur-quotidien/\">Continuer la lecture</a></span></p>\n",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

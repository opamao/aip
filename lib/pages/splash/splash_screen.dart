import 'package:aip/pages/menus/menus.dart';
import 'package:aip/utils/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _nbreSlides = demoData.length;
    super.initState();
  }

  late PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _pageIndex = 0;
  late int _nbreSlides;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: oranges,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => TestScreenContent(
                    logo: demoData[index].logo,
                    image: demoData[index].image,
                    titre: demoData[index].titre,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (_pageIndex + 1 == _nbreSlides) {
                        // passer au login
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenusScreen(),
                          ),
                        );
                        return;
                      }
                      _pageController.nextPage(
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 300));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greens,
                    ),
                    child: (_pageIndex + 1 == _nbreSlides)
                        ? const Text(
                            "Terminer",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        : const Text(
                            "Suivant",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TestScreenContent extends StatelessWidget {
  const TestScreenContent({
    Key? key,
    required this.logo,
    required this.image,
    required this.titre,
  }) : super(key: key);

  final String logo, image, titre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: oranges,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 250),
              child: Image.asset(logo),
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 40, right: 55),
              child: Image.asset(
                image,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              titre,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 29,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class Onboard {
  final String logo, image, titre;

  Onboard({
    required this.logo,
    required this.image,
    required this.titre,
  });
}
final List<Onboard> demoData = [
  Onboard(
    logo: "assets/images/logos.png",
    image: "assets/images/presse.png",
    titre: "PRESSES",
  ),
  Onboard(
    logo: "assets/images/logos.png",
    image: "assets/images/media.png",
    titre: "MEDIAS",
  ),
  Onboard(
    logo: "assets/images/logos.png",
    image: "assets/images/info.png",
    titre: "INFORMATIONS",
  ),
];

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: isActive ? 12 : 8,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? greens : greens.withOpacity(.5),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

import 'package:aip/pages/medias/medias_screen.dart';
import 'package:aip/pages/posts/presse_screen.dart';
import 'package:aip/pages/products/kisoques_screen.dart';
import 'package:aip/pages/users/users_screen.dart';
import 'package:flutter/material.dart';

class MenusScreen extends StatefulWidget {
  const MenusScreen({super.key});

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  int currentPageIndex = 0;

  final Widget _presse = const PresseScreen();
  final Widget _media = const MediasScreen();
  final Widget _kiosque = const KiosquesScreen();
  final Widget _profil = const UsersScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            label: 'Presse',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.monochrome_photos_outlined),
            icon: Icon(Icons.photo_camera_back_outlined),
            label: 'Media',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_cart_outlined),
            icon: Icon(Icons.newspaper_outlined),
            label: 'Kiosque',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_outlined),
            label: 'Profil',
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (currentPageIndex == 0) {
      return _presse;
    } else if (currentPageIndex == 1) {
      return _media;
    } else if (currentPageIndex == 2) {
      return _kiosque;
    } else {
      return _profil;
    }
  }
}

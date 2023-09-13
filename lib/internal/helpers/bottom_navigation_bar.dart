import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_morty/features/characters/presentation/screens/character_screen/character_screen.dart';
import 'package:rick_morty/features/episodes/presentation/screens/episode_screen.dart';
import 'package:rick_morty/features/locations/presentation/screens/location_screen/location_screen.dart';
import 'package:rick_morty/main.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> widgetsList = [
    const CharacterScreen(),const LocationScreen(),
    const EpisodeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: widgetsList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.cyan[700],
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(color: Colors.cyan[700]),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/cahracterIcon.svg'),
            activeIcon: SvgPicture.asset('assets/images/cahracterIcon.svg', color: Colors.cyan[700],),
         
            label: 'Персонажи',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/location.svg"),
             activeIcon: SvgPicture.asset('assets/images/location.svg', color: Colors.cyan[700],),
            label: 'Локации',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/episodes.svg", color: Colors.cyan[700],),
            label: 'Эпизоды',
          ),
          // BottomNavigationBarItem(
          //   icon: Image.asset("assets/images/Setting.3.svg"),
          //   label: 'Персонажи',
          // ),
        ],
      ),
    );
  }
}

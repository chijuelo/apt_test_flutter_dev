import 'package:apt_test_flutter_dev/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> tabs = [
    // PortfolioSection(),
    // MarketsSection(),
    // SearchSection(),
    // NewsSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kScaffoldBackground,
        body: tabs.elementAt(_selectedIndex),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: const Duration(milliseconds: 800),
                tabBackgroundColor: Colors.white30,
                selectedIndex: _selectedIndex,
                tabs: _bottomNavigationBarItemItems(),
                onTabChange: _onItemTapped),
          ),
        ));
  }

  List<GButton> _bottomNavigationBarItemItems() {
    return [
      const GButton(
        icon: FontAwesomeIcons.shapes,
        text: 'Home',
      ),
      const GButton(
        icon: FontAwesomeIcons.suitcase,
        text: 'Markets',
      ),
      const GButton(
        icon: FontAwesomeIcons.search,
        text: 'Search',
      ),
      const GButton(
        icon: FontAwesomeIcons.globeAmericas,
        text: 'News',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }
}

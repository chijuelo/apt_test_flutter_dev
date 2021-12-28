import 'package:apt_test_flutter_dev/shared/colors.dart';
import 'package:apt_test_flutter_dev/shared/config.dart';
import 'package:apt_test_flutter_dev/widgets/pages/home_page.dart';
import 'package:apt_test_flutter_dev/widgets/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> tabs = [
    const HomePage(),
    const SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kScaffoldBackground,
        body: tabs.elementAt(Config.selectedIndexGNB),
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
                selectedIndex: Config.selectedIndexGNB,
                tabs: _bottomNavigationBarItemItems(),
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                onTabChange: _onItemTapped),
          ),
        ));
  }

  List<GButton> _bottomNavigationBarItemItems() {
    return [
      const GButton(
        icon: FontAwesomeIcons.home,
        text: 'Home',
      ),
      const GButton(
        icon: FontAwesomeIcons.search,
        text: 'Search',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() => Config.selectedIndexGNB = index);
  }
}

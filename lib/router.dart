import 'package:apt_test_flutter_dev/widgets/home.dart';
import 'package:apt_test_flutter_dev/widgets/pages/market_page.dart';
import 'package:apt_test_flutter_dev/widgets/pages/search_page.dart';
import 'package:apt_test_flutter_dev/widgets/pages/user_settings_page.dart';
import 'package:flutter/material.dart';

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute(
      {required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (animation.status == AnimationStatus.reverse) {
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    }
    return FadeTransition(opacity: animation, child: child);
  }
}

MaterialPageRoute getRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/home':
      return MyCustomRoute(
        builder: (_) => const Home(),
        settings: settings,
      );
    case '/market':
      return MyCustomRoute(
        builder: (_) => const MarketPage(),
        settings: settings,
      );
    case '/search':
      return MyCustomRoute(
        builder: (_) => const SearchPage(),
        settings: settings,
      );
    case '/userSettings':
      return MyCustomRoute(
        builder: (_) => const UserSettingsPage(),
        settings: settings,
      );
    default:
      return MyCustomRoute(
        builder: (_) => const Home(),
        settings: settings,
      );
  }
}

import 'package:apt_test_flutter_dev/widgets/home.dart';
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
        builder: (_) => const HomePage(),
        settings: settings,
      );
    default:
      return MyCustomRoute(
        builder: (_) => const HomePage(),
        settings: settings,
      );
  }
}

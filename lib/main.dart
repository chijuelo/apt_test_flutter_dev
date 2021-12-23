import 'package:apt_test_flutter_dev/router.dart';
import 'package:apt_test_flutter_dev/widgets/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aptitude Test for Flutter Developer',
      onGenerateRoute: (RouteSettings settings) => getRoute(settings),
      home: const SplashScreen(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}

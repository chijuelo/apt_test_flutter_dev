import 'package:apt_test_flutter_dev/shared/colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kScaffoldBackground,
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}

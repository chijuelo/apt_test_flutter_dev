import 'package:apt_test_flutter_dev/shared/colors.dart';
import 'package:flutter/material.dart';

class MarketsPage extends StatelessWidget {
  const MarketsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kScaffoldBackground,
      body: Center(
        child: Text('Markets'),
      ),
    );
  }
}

import 'package:apt_test_flutter_dev/blocs/marcket_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  static Provider? _instancia;

  factory Provider({Key? key, Widget? child}) {
    _instancia ??= Provider._internal(key: key, child: child);

    return _instancia!;
  }

  Provider._internal({Key? key, Widget? child})
      : super(key: key, child: child!);

  final _marketBloc = MarketBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MarketBloc marketBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!._marketBloc;
  }
}

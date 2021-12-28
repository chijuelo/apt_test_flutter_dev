import 'dart:async';

import 'package:apt_test_flutter_dev/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class MarketBloc with Validators {
  final _symbolController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _countryController = BehaviorSubject<String>();
  final _industryController = BehaviorSubject<String>();
  final _ipoYearController = BehaviorSubject<String>();
  final _marketCapController = BehaviorSubject<String>();
  final _sectorController = BehaviorSubject<String>();
  final _volumeController = BehaviorSubject<String>();
  final _netChangeController = BehaviorSubject<String>();
  final _netChangePercentController = BehaviorSubject<String>();
  final _lastPriceController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get symbolStream =>
      _symbolController.stream.transform(validateSymbol);
  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);
  Stream<String> get countryStream =>
      _countryController.stream.transform(validateCountry);
  Stream<String> get industryStream =>
      _industryController.stream.transform(validateIndustry);
  Stream<String> get ipoYearStream =>
      _ipoYearController.stream.transform(validateIpoYear);
  Stream<String> get marketCapStream =>
      _marketCapController.stream.transform(validateMarketCap);
  Stream<String> get sectorStream =>
      _sectorController.stream.transform(validateSector);
  Stream<String> get volumeStream =>
      _volumeController.stream.transform(validateVolume);
  Stream<String> get netChangeStream =>
      _netChangeController.stream.transform(validateNetChange);
  Stream<String> get netChangePercentStream =>
      _netChangePercentController.stream.transform(validateNetChangePercent);
  Stream<String> get lastPriceStream =>
      _lastPriceController.stream.transform(validateLastPrice);

  Stream<bool> get _formValidStreamAux => Rx.combineLatest5(
      symbolStream,
      nameStream,
      countryStream,
      industryStream,
      ipoYearStream,
      (y, n, c, i, ip) => true);

  Stream<bool> get formValidStream => Rx.combineLatest7(
      _formValidStreamAux,
      marketCapStream,
      sectorStream,
      volumeStream,
      netChangeStream,
      netChangePercentStream,
      lastPriceStream,
      (aux, m, s, v, nch, nchp, l) => true);

  //Insertar valores al Stream
  Function(String) get changeSymbol => _symbolController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeCountry => _countryController.sink.add;
  Function(String) get changeIndustry => _industryController.sink.add;
  Function(String) get changeIpoYear => _ipoYearController.sink.add;
  Function(String) get changeMarketCap => _marketCapController.sink.add;
  Function(String) get changeSector => _sectorController.sink.add;
  Function(String) get changeVolume => _volumeController.sink.add;
  Function(String) get changeNetChange => _netChangeController.sink.add;
  Function(String) get changeNetChangePercent =>
      _netChangePercentController.sink.add;
  Function(String) get changeLastPrice => _lastPriceController.sink.add;

  //Obtener el ultimo valor ingresado en los stream
  String get symbol => _symbolController.value;
  String get name => _nameController.value;
  String get country => _countryController.value;
  String get industry => _industryController.value;
  String get ipoYear => _ipoYearController.value;
  String get marketCap => _marketCapController.value;
  String get sector => _sectorController.value;
  String get volume => _volumeController.value;
  String get netChange => _netChangeController.value;
  String get netChangePercent => _netChangePercentController.value;
  String get lastPrice => _lastPriceController.value;

  dispose() {
    _symbolController.close();
    _nameController.close();
    _countryController.close();
    _industryController.close();
    _ipoYearController.close();
    _marketCapController.close();
    _sectorController.close();
    _volumeController.close();
    _netChangeController.close();
    _netChangePercentController.close();
    _lastPriceController.close();
  }
}

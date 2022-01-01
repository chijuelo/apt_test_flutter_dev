import 'dart:convert';
import 'package:apt_test_flutter_dev/model/market_model.dart';
// import 'package:apt_test_flutter_dev/shared/config.dart';
import 'package:apt_test_flutter_dev/shared/preference.dart';

void findNewMarkets(List<MarketModel> newMap, List<dynamic> oldMap) {
  List<MarketModel> newMarkets = [];
  List<MarketModel> existMarkets = [];

  oldMap.map((v) {
    newMap.map((v1) {
      bool isEq = false;
      Map aux = (v as Map);
      for (String key in aux.keys) {
        if (v1.toJson()[key] != aux[key]) {
          isEq = false;
          break;
        }
      }
      if (isEq) {
        existMarkets.add(v1);
      }
    }).toList();
  }).toList();

  newMap.map((v) {
    existMarkets.map((v1) {
      if (v != v1) {
        newMarkets.add(v);
      }
    }).toList();
  }).toList();

  // Config.cantNewMarket = newMarkets.length;

  Preferences().newMarkets = json.encode(newMarkets);
}

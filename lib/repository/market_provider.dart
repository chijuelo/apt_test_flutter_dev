import 'dart:convert';

import 'package:apt_test_flutter_dev/model/market_model.dart';
import 'package:apt_test_flutter_dev/shared/config.dart';
import 'package:http/http.dart' as http;

class MarketProvider {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<Map<String, dynamic>> getMarket(String id) async {
    final query = await _accionGet('markets/$id', 'data');
    return {
      "ok": query["ok"],
      'data': query['ok'] ? MarketModel.fromJson(query['data']) : query['data']
    };
  }

  Future<Map<String, dynamic>> updateMarket(String id, MarketModel data) async {
    final query =
        await _accionPatch('markets/$id', marketModelToJson(data), 'data');
    return {
      "ok": query["ok"],
      'data': query['ok'] ? MarketModel.fromJson(query['data']) : query['data']
    };
  }

  Future<Map<String, dynamic>> replaceMarket(
      String id, MarketModel data) async {
    final query =
        await _accionPut('markets/$id', marketModelToJson(data), 'data');
    return {
      "ok": query["ok"],
      'data': query['ok'] ? MarketModel.fromJson(query['data']) : query['data']
    };
  }

  Future<Map<String, dynamic>> deleteMarket(String id) async {
    final query = await _accionDelete('markets/$id');
    return {
      "ok": query["ok"],
      'data': query['ok'] ? MarketModel.fromJson(query['data']) : query['data']
    };
  }

  Future<Map<String, dynamic>> getMarkets(String queryParams) async {
    final query = await _accionGet('markets$queryParams', 'data');
    return {
      "ok": query["ok"],
      'data': query['ok'] ? MarketModel.parseList(query['data']) : query['data']
    };
  }

  Future<Map<String, dynamic>> createMarket(MarketModel data) async {
    final query = await _accionPost('markets', marketModelToJson(data), 'data');
    return {
      "ok": query["ok"],
      'data': query['ok'] ? MarketModel.fromJson(query['data']) : query['data']
    };
  }

  Future<Map<String, dynamic>> createMarkets(List<MarketModel> data) async {
    final query = await _accionPost('markets/bulk', data, 'data');
    return {
      "ok": query["ok"],
      'data': query['ok'] ? MarketModel.parseList(query['data']) : query['data']
    };
  }

  Future<Map<String, dynamic>> _accionPost(
      String accion, myData, String responseName) async {
    try {
      final resp = await http.post(Uri.parse(Config.apiUrl + accion),
          headers: headers, body: myData);
      if (resp.statusCode >= 200 && resp.statusCode <= 299) {
        final decodeResp = json.decode(resp.body);
        return {'ok': true, responseName: decodeResp};
      } else {
        return _manejadorErroresResp(resp);
      }
    } catch (e) {
      return _retornarErrorDesconocido();
    }
  }

  Future<Map<String, dynamic>> _accionPatch(
      String accion, myData, String responseName) async {
    try {
      final resp = await http.patch(Uri.parse(Config.apiUrl + accion),
          headers: headers, body: myData);
      if (resp.statusCode >= 200 && resp.statusCode <= 299) {
        final decodeResp = json.decode(resp.body);
        return {'ok': true, responseName: decodeResp};
      } else {
        return _manejadorErroresResp(resp);
      }
    } catch (e) {
      return _retornarErrorDesconocido();
    }
  }

  Future<Map<String, dynamic>> _accionPut(
      String accion, myData, String responseName) async {
    try {
      final resp = await http.put(Uri.parse(Config.apiUrl + accion),
          headers: headers, body: myData);
      if (resp.statusCode >= 200 && resp.statusCode <= 299) {
        final decodeResp = json.decode(resp.body);
        return {'ok': true, responseName: decodeResp};
      } else {
        return _manejadorErroresResp(resp);
      }
    } catch (e) {
      return _retornarErrorDesconocido();
    }
  }

  Future<Map<String, dynamic>> _accionDelete(String accion) async {
    try {
      final resp = await http.delete(Uri.parse(Config.apiUrl + accion));
      if (resp.statusCode >= 200 && resp.statusCode <= 299) {
        // final decodeResp = json.decode(resp.body);
        // return {'ok': true, 'data': decodeResp};
        return {'ok': true};
      } else {
        return _manejadorErroresResp(resp);
      }
    } catch (e) {
      return _retornarErrorDesconocido();
    }
  }

  Future<Map<String, dynamic>> _accionGet(
      String accion, String responseName) async {
    try {
      final resp = await http.get(Uri.parse(Config.apiUrl + accion));
      if (resp.statusCode >= 200 && resp.statusCode <= 299) {
        final decodeResp = json.decode(resp.body);
        return {"ok": true, "data": decodeResp};
      } else {
        return _manejadorErroresResp(resp);
      }
    } catch (e) {
      return _retornarErrorDesconocido();
    }
  }

  Future<Map<String, dynamic>> _manejadorErroresResp(http.Response resp) async {
    if (resp.statusCode == 422) {
      final decodeResp = json.decode(resp.body);
      if (resp.body.contains('data')) {
        return {'ok': false, 'errores': decodeResp['data']};
      }
      decodeResp[0]['status'] = resp.statusCode;
      return {'ok': false, 'errores': decodeResp};
    } else if (resp.statusCode == 401) {
      final decodeResp = json.decode(resp.body);
      if (resp.body.contains('data')) {
        return {'ok': false, 'errores': decodeResp['data']};
      }
      return {'ok': false, 'errores': decodeResp};
    } else if (resp.statusCode == 429) {
      final decodeResp = json.decode(resp.body);
      if (resp.body.contains('data')) {
        return {'ok': false, 'errores': decodeResp['data']};
      }
      return {'ok': false, 'errores': decodeResp};
    } else {
      final decodeResp = json.decode(resp.body);
      List result = [];
      result.add({
        'field': 'error',
        'message': decodeResp['message'] ??
            'Ha ocurrido un error! Inténtelo más tarde.'
      });
      return {'ok': false, 'errores': result};
    }
  }

  _retornarErrorDesconocido() {
    List decodeResp = [];
    decodeResp.add({
      'field': 'error_desconocido',
      'message': 'Ha ocurrido un error! Inténtelo más tarde.'
    });
    return {'ok': false, 'errores': decodeResp};
  }
}

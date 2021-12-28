/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new Preferences();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  SharedPreferences? _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  clear() async {
    _prefs?.clear();
  }

  // GETs y SETs
  String get markets {
    return _prefs?.getString('markets') ?? '';
  }

  set markets(String value) {
    _prefs?.setString('markets', value);
  }

  bool get dataSaving {
    return _prefs?.getBool('dataSaving') ?? false;
  }

  set dataSaving(bool value) {
    _prefs?.setBool('dataSaving', value);
  }

  List<String> get catSelHome {
    return _prefs?.getStringList('catSelHome') ?? [];
  }

  set catSelHome(List<String> value) {
    _prefs?.setStringList('catSelHome', value);
  }

  List<String> get catSelSearch {
    return _prefs?.getStringList('catSelSearch') ?? [];
  }

  set catSelSearch(List<String> value) {
    _prefs?.setStringList('catSelSearch', value);
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:apt_test_flutter_dev/model/market_model.dart';
import 'package:apt_test_flutter_dev/repository/market_provider.dart';
import 'package:apt_test_flutter_dev/shared/colors.dart';
import 'package:apt_test_flutter_dev/shared/config.dart';
import 'package:apt_test_flutter_dev/shared/preference.dart';
import 'package:apt_test_flutter_dev/widgets/pages/categories_page.dart';
import 'package:apt_test_flutter_dev/widgets/utils/alert.dart';
import 'package:apt_test_flutter_dev/widgets/utils/appbar.dart';
// import 'package:apt_test_flutter_dev/widgets/utils/find_new_markets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MarketProvider _marketProvider = MarketProvider();
  bool _flagLoadMarkets = true;
  List<MarketModel> _markets = [];
  late Size _size;
  late MarketModel _selectedMarket;
  final Preferences _pref = Preferences();
  sort? _sort = sort.noSort;
  Orientation _orientation = Orientation.portrait;
  List<dynamic> _marketsPref = [];
  int _index = 1;

  @override
  void initState() {
    Config.categories.updateAll((key, value) => false);
    final aux = _pref.catSelHome;
    aux.map((e) => Config.categories[e] = true).toList();

    if (_pref.markets != '') _marketsPref = jsonDecode(_pref.markets);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return OrientationBuilder(builder: (context, orientation) {
      _orientation = orientation;
      return FutureBuilder(
        future: _loadMarkets(),
        builder:
            (BuildContext context, AsyncSnapshot<List<MarketModel>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: kScaffoldBackground,
              appBar: CustomAppBar(
                label: 'Markets',
                // cantNewMarket: Config.cantNewMarket,
              ),
              body: _buildContent(context, snapshot.data!),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    });
  }

  Future<List<MarketModel>> _loadMarkets() async {
    if (_flagLoadMarkets) {
      try {
        if (Config.onLine && await InternetConnectionChecker().hasConnection) {
          String queryParams = '';

          if (_sort != sort.noSort) {
            final aux = _sort.toString().substring(5).toUpperCase();
            queryParams += queryParams != '' ? '&sort=$aux' : '?sort=$aux';
          }

          if (queryParams != '') {
            int indexEq = queryParams.indexOf('=');
            String aux1 = queryParams.substring(0, indexEq + 1);
            String aux2 = queryParams.substring(indexEq + 1);

            Config.categories.forEach((key, value) {
              if (value) {
                queryParams = '$aux1${key.toLowerCase()},$aux2';
              }
            });
          } else if (Config.categories.containsValue(true)) {
            queryParams = '?fields=name,';
            Config.categories.forEach((key, value) {
              if (value) {
                queryParams += '${key.toLowerCase()},';
              }
            });
            queryParams = queryParams.substring(0, queryParams.length - 1);
          }

          final Map<String, dynamic>? result =
              await _marketProvider.getMarkets(queryParams);
          if (result!['ok']) {
            _markets = result['data'];
            // findNewMarkets(_markets, _marketsPref);
            _pref.markets = json.encode(_markets);
            _selectedMarket = _markets[0];
            _flagLoadMarkets = false;
          } else {
            log(result['data']);
          }
        } else {
          if (!Config.onLine) {
            _markets.clear();
            _marketsPref.map((m) {
              _markets.add(MarketModel.fromJson(m));
            }).toList();

            if (_sort != sort.noSort) {
              // _markets.sort((m1, m2) =>
              //     m1.name!.toLowerCase().compareTo(m2.name!.toLowerCase()));

              for (var i = 0; i < _markets.length; i++) {
                for (var j = i; j < _markets.length - 1; j++) {
                  MarketModel aux = _markets[i];
                  if (aux.name!
                          .toLowerCase()
                          .compareTo(_markets[j].name!.toLowerCase()) ==
                      1) {
                    _markets[i] = _markets[j];
                    _markets[j] = aux;
                  }
                }
              }
              _pref.markets = json.encode(_markets);

              _sort = sort.noSort;
            }
            _selectedMarket = _markets[0];
            _flagLoadMarkets = false;
          } else {
            Config.onLine = true;
            if (Config.flagShowAlert) {
              Config.flagShowAlert = false;
              showAlert(context, 'You ar offline, please connet and try again.',
                  false, false);
            }
          }
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return _markets;
  }

  _optWin() async {
    const newWin = CategoriesPage();
    _sort = await showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder:
              (context, Animation animation, Animation secondaryAnimation) {
            return newWin;
          },
        ) ??
        sort.noSort;

    //fill categories preference
    List<String> aux = [];
    Config.categories.forEach((key, value) {
      if (value) {
        aux.add(key);
      }
    });
    _pref.catSelHome = aux;

    setState(() {
      _flagLoadMarkets = true;
    });
  }

  Widget _buildContent(BuildContext context, List<MarketModel> data) {
    return RefreshIndicator(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: data.length != 0
            ? Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '$_index / ${_markets.length}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => _optWin(),
                            child: const FaIcon(FontAwesomeIcons.slidersH),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: _orientation == Orientation.portrait ? 2 : 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: CarouselSlider(
                          items: _marketsCards(data),
                          options: CarouselOptions(
                            height: _size.height * 0.35,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: false,
                            onPageChanged: (index, value) {
                              if (data.length <= index) {
                                final aux = index ~/ data.length;
                                index = index - (aux * 20);
                              }
                              setState(() {
                                _index = index + 1;
                                _selectedMarket = data[index];
                              });
                            },
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child:
                          SingleChildScrollView(child: _marketDescriptions())),
                ],
              )
            : Center(
                child: Text(
                'Data no found',
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              )),
      )),
      onRefresh: () async {
        setState(() {
          _flagLoadMarkets = true;
        });
      },
    );
  }

  List<Widget> _marketsCards(List<MarketModel> data) {
    List<Widget> _listWidgets = [];
    data
        .map((m) => _listWidgets.add(Padding(
              padding: const EdgeInsets.all(8.0),
              child: _card(m),
            )))
        .toList();
    return _listWidgets;
  }

  Widget _card(MarketModel market) {
    return Material(
      elevation: 10,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26), topRight: Radius.circular(26)),
      type: MaterialType.card,
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed('/market', arguments: _selectedMarket),
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black54),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26)),
            gradient: const LinearGradient(
              colors: [
                kScaffoldBackground,
                kScaffoldBackground,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26)),
                  child: Image.asset(
                    'assets/images/pics/Vector.png',
                    color: Colors.black,
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26)),
                  child: Image.asset(
                    'assets/images/pics/Vector-1.png',
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: market.id!,
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            market.name!,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        market.country!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed('/market', arguments: _selectedMarket),
                        child: const FaIcon(
                          FontAwesomeIcons.edit,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final Map<String, dynamic>? result =
                              await _marketProvider
                                  .deleteMarket(_selectedMarket.id.toString());

                          if (result!['ok']) {
                            showAlert(
                                context, 'The market was deleted', true, false);
                          }
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.trashAlt,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _marketDescriptions() {
    List<Widget> listAux = [];
    bool paint = true, all = !Config.categories.containsValue(true);

    //Always name is painted
    listAux.add(_row('Name:', _selectedMarket.name!));

    Config.categories.forEach((key, value) {
      if (value || all) {
        if (paint) {
          paint = false;
          listAux.add(Container(
              color: Colors.black26,
              child: _row(
                  '$key:', _selectedMarket.configToValue()[key]!.toString())));
        } else {
          paint = true;
          listAux.add(
              _row('$key:', _selectedMarket.configToValue()[key]!.toString()));
        }
      }
    });

    return Column(children: listAux);
  }

  Widget _row(String labe, String data) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              labe,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            data,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

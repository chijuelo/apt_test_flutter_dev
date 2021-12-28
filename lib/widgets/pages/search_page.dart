import 'dart:developer';

import 'package:apt_test_flutter_dev/model/market_model.dart';
import 'package:apt_test_flutter_dev/repository/market_provider.dart';
import 'package:apt_test_flutter_dev/shared/colors.dart';
import 'package:apt_test_flutter_dev/shared/config.dart';
import 'package:apt_test_flutter_dev/shared/preference.dart';
import 'package:apt_test_flutter_dev/widgets/pages/categories_page.dart';
import 'package:apt_test_flutter_dev/widgets/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final MarketProvider _marketProvider = MarketProvider();
  bool _flagLoadMarkets = true;
  List<MarketModel> _markets = [];
  late Size _size;
  final TextEditingController _searchTEC = TextEditingController();
  final Preferences _pref = Preferences();
  sort? _sort = sort.noSort;

  @override
  void initState() {
    Config.categories.updateAll((key, value) => false);
    final aux = _pref.catSelSearch;
    aux.map((e) => Config.categories[e] = true).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _loadMarkets(),
      builder:
          (BuildContext context, AsyncSnapshot<List<MarketModel>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: kScaffoldBackground,
            appBar: const CustomAppBar(
              label: 'Search Market',
              cantNewMarket: Config.cantNewMarket,
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
  }

  Future<List<MarketModel>> _loadMarkets() async {
    if (_flagLoadMarkets) {
      try {
        String queryParams = '';
        if (!_pref.dataSaving) {
          queryParams =
              _searchTEC.text == '' ? '' : '?s={"name": ${_searchTEC.text}}';

          if (Config.categories.containsValue(true)) {
            queryParams +=
                queryParams != '' ? '&fields=name,' : '?fields=name,';
            Config.categories.forEach((key, value) {
              if (value) {
                queryParams += '${key.toLowerCase()},';
              }
            });
            queryParams = queryParams.substring(0, queryParams.length - 1);
          }

          if (_sort != sort.noSort) {
            queryParams += queryParams != '' ? '&sort=$_sort' : '?sort=$_sort';
          }
        }
        final result = await _marketProvider.getMarkets(queryParams);
        if (result['ok']) {
          _markets = result['data'];
          _flagLoadMarkets = false;
        } else {
          log(result['data']);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return _markets;
  }

  Widget _buildContent(BuildContext context, List<MarketModel> data) {
    return RefreshIndicator(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(flex: 1, child: _searchWidget()),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: Column(
                  children: _marketsCards(data),
                ),
              ),
            ),
          ],
        ),
      )),
      onRefresh: () async {
        _flagLoadMarkets = true;
        log('reload');
      },
    );
  }

  Widget _searchWidget() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FaIcon(FontAwesomeIcons.search),
          SizedBox(
            width: _size.width * 0.7,
            child: TextField(
              controller: _searchTEC,
            ),
          ),
          GestureDetector(
            onTap: () => _optWin(),
            child: const FaIcon(FontAwesomeIcons.slidersH),
          )
        ],
      ),
    );
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
    _pref.catSelSearch = aux;

    setState(() {
      _flagLoadMarkets = true;
    });
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
    return SizedBox(
      height: _size.height * 0.2,
      width: _size.width * 0.9,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              Navigator.of(context).pushNamed('/market', arguments: market),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black54),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(26),
                    topRight: Radius.circular(26)),
                gradient: const LinearGradient(
                  colors: [
                    Colors.black26,
                    Colors.white30,
                  ],
                  begin: Alignment.center,
                  end: Alignment.topCenter,
                ),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: _size.height * 0.2,
                    width: _size.width * 0.9,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(26),
                          topRight: Radius.circular(26)),
                      child: Image.asset(
                        'assets/images/pics/Vector.png',
                        color: Colors.black,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _size.height * 0.2,
                    width: _size.width * 0.9,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(26),
                          topRight: Radius.circular(26)),
                      child: Image.asset(
                        'assets/images/pics/Vector-1.png',
                        color: Colors.black,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

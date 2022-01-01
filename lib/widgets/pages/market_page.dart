import 'package:apt_test_flutter_dev/blocs/marcket_bloc.dart';
import 'package:apt_test_flutter_dev/blocs/provider_boc.dart' as provider_bloc;
import 'package:apt_test_flutter_dev/model/market_model.dart';
import 'package:apt_test_flutter_dev/repository/market_provider.dart'
    as provider_market;
import 'package:apt_test_flutter_dev/shared/colors.dart';
import 'package:apt_test_flutter_dev/shared/config.dart';
import 'package:apt_test_flutter_dev/widgets/utils/alert.dart';
import 'package:apt_test_flutter_dev/widgets/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final provider_market.MarketProvider _marketProvider =
      provider_market.MarketProvider();
  late Size _size;
  late MarketBloc _marketBloc;
  bool _isCreate = false,
      _isUpdate = false,
      _flagLoadMarket = true,
      _saving = false;
  int _idMarket = -1;
  DateTime created = DateTime.now(), updated = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _marketBloc = provider_bloc.Provider.marketBloc(context);
    _size = MediaQuery.of(context).size;
    _loadMarket();
    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: Scaffold(
        backgroundColor: kScaffoldBackground,
        appBar: const CustomAppBar(label: 'Create Market'),
        body: _buildContent(context),
      ),
      opacity: 0.5,
      progressIndicator: const CircularProgressIndicator(),
    );
  }

  void _loadMarket() {
    if (_flagLoadMarket) {
      final _market = ModalRoute.of(context)!.settings.arguments;
      if (_market != null) {
        _isUpdate = true;
        _marketBloc.changeSymbol((_market as MarketModel).symbol!);
        _marketBloc.changeName(_market.name!);
        _marketBloc.changeCountry(_market.country!);
        _marketBloc.changeIndustry(_market.industry!);
        _marketBloc.changeIpoYear(_market.ipoYear!.toString());
        _marketBloc.changeMarketCap(_market.marketCap!.toString());
        _marketBloc.changeSector(_market.sector!);
        _marketBloc.changeVolume(_market.volume!.toString());
        _marketBloc.changeNetChange(_market.netChange!.toString());
        _marketBloc
            .changeNetChangePercent(_market.netChangePercent!.toString());
        _marketBloc.changeLastPrice(_market.lastPrice!.toString());
        _idMarket = _market.id!;
      } else {
        _isCreate = true;
        _marketBloc.changeSymbol('');
        _marketBloc.changeName('');
        _marketBloc.changeCountry('');
        _marketBloc.changeIndustry('');
        _marketBloc.changeIpoYear('');
        _marketBloc.changeMarketCap('');
        _marketBloc.changeSector('');
        _marketBloc.changeVolume('');
        _marketBloc.changeNetChange('');
        _marketBloc.changeNetChangePercent('');
        _marketBloc.changeLastPrice('');
      }
      _flagLoadMarket = false;
    }
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            !_isCreate && Config.onLine
                ? _createReplaceMarket()
                : const SizedBox(),
            _createFields(),
            Config.onLine ? _createButton() : const SizedBox(),
          ],
        ),
      ),
    ));
  }

  Widget _createReplaceMarket() {
    return Row(
      children: [
        const Text(
          'Replace all info of the market',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Switch(
            value: !_isUpdate,
            onChanged: (v) => setState(() {
                  _isUpdate = !v;
                })),
      ],
    );
  }

  Widget _createFields() {
    return Padding(
      padding: EdgeInsets.only(bottom: _size.height * 0.02),
      child: Column(children: [
        _row(
            label: 'Symbol:',
            data: _marketBloc.symbol,
            keyboardType: TextInputType.multiline,
            onChanged: _marketBloc.changeSymbol,
            stream: _marketBloc.symbolStream,
            hintText: 'AAA'),
        Container(
          color: Colors.black26,
          child: _row(
              label: 'Name:',
              data: _marketBloc.name,
              keyboardType: TextInputType.multiline,
              onChanged: _marketBloc.changeName,
              stream: _marketBloc.nameStream,
              hintText: 'QvaPay'),
        ),
        _row(
            label: 'Country:',
            data: _marketBloc.country,
            keyboardType: TextInputType.multiline,
            onChanged: _marketBloc.changeCountry,
            stream: _marketBloc.countryStream,
            hintText: 'Cuba'),
        Container(
          color: Colors.black26,
          child: _row(
              label: 'Industry:',
              data: _marketBloc.industry,
              keyboardType: TextInputType.multiline,
              onChanged: _marketBloc.changeIndustry,
              stream: _marketBloc.industryStream,
              hintText: 'Avidi Technologies'),
        ),
        _row(
            label: 'Ipo Year:',
            data: _marketBloc.ipoYear,
            keyboardType: TextInputType.number,
            onChanged: _marketBloc.changeIpoYear,
            stream: _marketBloc.ipoYearStream,
            hintText: '1492'),
        Container(
          color: Colors.black26,
          child: _row(
              label: 'Market Cap:',
              data: _marketBloc.marketCap,
              keyboardType: TextInputType.number,
              onChanged: _marketBloc.changeMarketCap,
              stream: _marketBloc.marketCapStream,
              hintText: '111111'),
        ),
        _row(
            label: 'Sector:',
            data: _marketBloc.sector,
            keyboardType: TextInputType.multiline,
            onChanged: _marketBloc.changeSector,
            stream: _marketBloc.sectorStream,
            hintText: 'Programming Technologies'),
        Container(
          color: Colors.black26,
          child: _row(
              label: 'Volume:',
              data: _marketBloc.volume,
              keyboardType: TextInputType.number,
              onChanged: _marketBloc.changeVolume,
              stream: _marketBloc.volumeStream,
              hintText: '10'),
        ),
        _row(
            label: 'Net Change:',
            data: _marketBloc.netChange,
            keyboardType: TextInputType.number,
            onChanged: _marketBloc.changeNetChange,
            stream: _marketBloc.netChangeStream,
            hintText: '10.5'),
        Container(
          color: Colors.black26,
          child: _row(
              label: 'Net Change Percent:',
              data: _marketBloc.netChangePercent,
              keyboardType: TextInputType.number,
              onChanged: _marketBloc.changeNetChangePercent,
              stream: _marketBloc.netChangePercentStream,
              hintText: '100'),
        ),
        _row(
            label: 'Last Price:',
            data: _marketBloc.lastPrice,
            keyboardType: TextInputType.number,
            onChanged: _marketBloc.changeLastPrice,
            stream: _marketBloc.lastPriceStream,
            hintText: '300.5'),
      ]),
    );
  }

  Widget _row(
      {String? label,
      String? data,
      TextInputType? keyboardType,
      int? maxLines,
      Function(String)? onChanged,
      Stream? stream,
      String? hintText}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              label!,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: StreamBuilder(
                stream: stream,
                builder: (context, snapshot) {
                  return TextFormField(
                    readOnly: !Config.onLine,
                    initialValue: data,
                    keyboardType: keyboardType,
                    maxLines: maxLines,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      focusedErrorBorder: InputBorder.none,
                      errorStyle: snapshot.hasError
                          ? const TextStyle(color: Colors.red, fontSize: 20)
                          : const TextStyle(
                              color: Colors.transparent, fontSize: 0),
                      errorText: snapshot.error.toString(),
                      errorBorder: InputBorder.none,
                      hintText: hintText,
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontFamily: 'Quicksand'),
                    ),
                  );
                })),
      ],
    );
  }

  Widget _createButton() {
    return StreamBuilder(
        stream: _marketBloc.formValidStream,
        builder: (context, snapshot) {
          return Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: snapshot.hasData ? () => _save() : null,
                  borderRadius: BorderRadius.circular(26),
                  child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: snapshot.hasData
                                ? Colors.white
                                : kScaffoldBackground),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _isUpdate
                              ? 'Update'
                              : _isCreate
                                  ? 'Create'
                                  : 'Replace',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: snapshot.hasData
                                  ? Colors.white
                                  : kScaffoldBackground),
                        ),
                      ))));
        });
  }

  _save() async {
    setState(() {
      _saving = true;
    });

    MarketModel data = MarketModel(
      symbol: _marketBloc.symbol,
      name: _marketBloc.name,
      country: _marketBloc.country,
      industry: _marketBloc.industry,
      ipoYear: int.tryParse(_marketBloc.ipoYear),
      marketCap: int.tryParse(_marketBloc.marketCap),
      sector: _marketBloc.sector,
      volume: int.tryParse(_marketBloc.volume),
      netChange: double.tryParse(_marketBloc.netChange),
      netChangePercent: double.tryParse(_marketBloc.netChangePercent),
      lastPrice: double.tryParse(_marketBloc.lastPrice),
      createdAt: created,
      updatedAt: updated,
    );

    Map resp = _isUpdate
        ? await _marketProvider.updateMarket(_idMarket.toString(), data)
        : _isCreate
            ? await _marketProvider.createMarket(data)
            : await _marketProvider.replaceMarket(_idMarket.toString(), data);

    setState(() {
      _saving = false;
    });

    if (resp['ok']) {
      if (resp['data'] != null) {
        showAlert(
            context,
            'The market ${(resp['data'] as MarketModel).name} was ${_isUpdate ? 'updated' : _isCreate ? 'created' : 'replaced'}',
            true,
            true);
      } else {
        showAlert(context, resp['error'], false, true);
      }
    } else {
      showAlert(context, resp['error'], false, true);
    }
  }
}

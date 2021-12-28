import 'dart:async';

class Validators {
  final validateSymbol = StreamTransformer<String, String>.fromHandlers(
      handleData: (symbol, sink) {
    if (symbol.trim().isNotEmpty) {
      sink.add(symbol);
    } else {
      sink.addError('The symbol field cannot be empty.');
    }
  });

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.trim().isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError('The name field cannot be empty.');
    }
  });

  final validateCountry = StreamTransformer<String, String>.fromHandlers(
      handleData: (country, sink) {
    if (country.trim().isNotEmpty) {
      sink.add(country);
    } else {
      sink.addError('The country field cannot be empty.');
    }
  });

  final validateIndustry = StreamTransformer<String, String>.fromHandlers(
      handleData: (industry, sink) {
    if (industry.trim().isNotEmpty) {
      sink.add(industry);
    } else {
      sink.addError('The industry field cannot be empty.');
    }
  });

  final validateIpoYear = StreamTransformer<String, String>.fromHandlers(
      handleData: (ipoYear, sink) {
    if (ipoYear.trim().isNotEmpty &&
        int.tryParse(ipoYear).toString().length == 4 &&
        ipoYear[0] != '0') {
      sink.add(ipoYear);
    } else {
      sink.addError('IpoYear, it most be four numbers');
    }
  });

  final validateSector = StreamTransformer<String, String>.fromHandlers(
      handleData: (sector, sink) {
    if (sector.isNotEmpty) {
      sink.add(sector);
    } else {
      sink.addError('The sector field cannot be empty.');
    }
  });

  final validateVolume = StreamTransformer<String, String>.fromHandlers(
      handleData: (volume, sink) {
    if (volume.isNotEmpty) {
      sink.add(volume);
    } else {
      sink.addError('The volume field cannot be empty.');
    }
  });

  final validateMarketCap = StreamTransformer<String, String>.fromHandlers(
      handleData: (marketCap, sink) {
    if (marketCap.isNotEmpty) {
      sink.add(marketCap);
    } else {
      sink.addError('The market cap field cannot be empty.');
    }
  });
  final validateNetChange = StreamTransformer<String, String>.fromHandlers(
      handleData: (netChange, sink) {
    if (netChange.isNotEmpty) {
      sink.add(netChange);
    } else {
      sink.addError('The net change field cannot be empty.');
    }
  });
  final validateNetChangePercent =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (netChangePercent, sink) {
    if (netChangePercent.isNotEmpty) {
      sink.add(netChangePercent);
    } else {
      sink.addError('The net change percent field cannot be empty.');
    }
  });
  final validateLastPrice = StreamTransformer<String, String>.fromHandlers(
      handleData: (lastPrice, sink) {
    if (lastPrice.isNotEmpty) {
      sink.add(lastPrice);
    } else {
      sink.addError('The last price field cannot be empty.');
    }
  });
}

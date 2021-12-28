// To parse this JSON data, do
//
//     final marketModel = marketModelFromJson(jsonString);

import 'dart:convert';

MarketModel marketModelFromJson(String str) =>
    MarketModel.fromJson(json.decode(str));

String marketModelToJson(MarketModel data) => json.encode(data.toJson());

class MarketModel {
  String? symbol, name, country, industry, sector;
  int? ipoYear, marketCap, volume, id;
  double? netChange, netChangePercent, lastPrice;
  DateTime? createdAt, updatedAt;

  MarketModel({
    required this.symbol,
    required this.name,
    required this.country,
    required this.industry,
    required this.ipoYear,
    required this.marketCap,
    required this.sector,
    required this.volume,
    required this.netChange,
    required this.netChangePercent,
    required this.lastPrice,
    required this.createdAt,
    required this.updatedAt,
    this.id,
  });

  factory MarketModel.fromJson(Map<String, dynamic> json) => MarketModel(
        symbol: json["symbol"] ?? '',
        name: json["name"] ?? '',
        country: json["country"] ?? '',
        industry: json["industry"] ?? '',
        ipoYear: json["ipoYear"] ?? 0,
        marketCap: json["marketCap"] ?? 0,
        sector: json["sector"] ?? '',
        volume: json["volume"] ?? 0,
        netChange: json["netChange"] is int
            ? double.parse(json["netChange"].toString() + '.0')
            : json["netChange"] ?? 0.0,
        netChangePercent: json["netChangePercent"] is int
            ? double.parse(json["netChangePercent"].toString() + '.0')
            : json["netChangePercent"] ?? 0.0,
        lastPrice: json["lastPrice"] is int
            ? double.parse(json["lastPrice"].toString() + '.0')
            : json["lastPrice"] ?? 0.0,
        createdAt:
            DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "country": country,
        "industry": industry,
        "ipoYear": ipoYear,
        "marketCap": marketCap,
        "sector": sector,
        "volume": volume,
        "netChange": netChange,
        "netChangePercent": netChangePercent,
        "lastPrice": lastPrice,
        "createdAt": createdAt.toString(),
        "updatedAt": updatedAt.toString(),
        "id": id,
      };

  Map<String, dynamic> configToValue() => {
        'Symbol': symbol,
        'Name': name,
        'Country': country,
        'Industry': industry,
        'Ipo Year': ipoYear,
        'Market Cap': marketCap,
        'Sector': sector,
        'Volume': volume,
        'Net Change': netChange,
        'Net Change Percent': netChangePercent,
        'Last Price': lastPrice,
        'Created At': createdAt.toString(),
        'Updated At': updatedAt.toString(),
        'Id': id,
      };

  static List<MarketModel> parseList(map) {
    var list = map as List;
    return list.map((s) => MarketModel.fromJson(s)).toList();
  }
}

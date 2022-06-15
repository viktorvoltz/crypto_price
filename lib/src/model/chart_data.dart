// To parse this JSON data, do
//
//     final chartData = chartDataFromJson(jsonString);

import 'dart:convert';

ChartData chartDataFromJson(String str) => ChartData.fromJson(json.decode(str));

String chartDataToJson(ChartData data) => json.encode(data.toJson());

class ChartData {
    ChartData({
        this.prices,
        this.marketCaps,
        this.totalVolumes,
    });

    List<List<double>>? prices;
    List<List<double>>? marketCaps;
    List<List<double>>? totalVolumes;

    factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
        prices: json["prices"] == null ? null : List<List<double>>.from(json["prices"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
        marketCaps: json["market_caps"] == null ? null : List<List<double>>.from(json["market_caps"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
        totalVolumes: json["total_volumes"] == null ? null : List<List<double>>.from(json["total_volumes"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
    );

    Map<String, dynamic> toJson() => {
        "prices": prices == null ? null : List<dynamic>.from(prices!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "market_caps": marketCaps == null ? null : List<dynamic>.from(marketCaps!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "total_volumes": totalVolumes == null ? null : List<dynamic>.from(totalVolumes!.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}

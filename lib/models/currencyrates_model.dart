import 'dart:convert';

RatesModel ratesModelFromJson(String str) =>
    RatesModel.fromJson(json.decode(str));

class RatesModel {
  String disclaimer;
  String license;
  int timestamp;
  String base;
  Map<String, double> rates;

  RatesModel({
    required this.disclaimer,
    required this.license,
    required this.timestamp,
    required this.base,
    required this.rates,
  });

  factory RatesModel.fromJson(Map<String, dynamic> json) => RatesModel(
        disclaimer: json["disclaimer"] ?? '',
        license: json["license"] ?? '',
        timestamp: json["timestamp"] ?? 0,
        base: json["base"] ?? '',
        rates: Map.from(json["rates"])
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );
}

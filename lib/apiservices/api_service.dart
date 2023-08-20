import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/currency_model.dart';
import '../models/currencyrates_model.dart';
import '../utils/constants.dart';

class ApiService {
  fetchCurrency() async {
    String url =
        'https://openexchangerates.org/api/currencies.json?app_id=$apiKey';

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        final result = currencyModelFromJson(response.body);

        return result;
      }
    } catch (error) {
      debugPrint('something went wrong $error');
    }
  }

  Future<RatesModel?> fetchCurrencyRates() async {
    String url = 'https://openexchangerates.org/api/latest.json?app_id=$apiKey';

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        RatesModel model = RatesModel.fromJson(result);
        debugPrint('Currency rates $model');
        return model;
      }
    } catch (error) {
      debugPrint('Unable to Fetch Currency Rates $error');
    }
    return null;
  }
}

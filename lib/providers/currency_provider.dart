import 'package:flutter/material.dart';

import '../apiservices/api_service.dart';
import '../utils/constants.dart';

class CurrencyProvider extends ChangeNotifier {
  Map _currencyList = {};
  Map _currencyRatesList = {};
  bool _isLoading = false;
  String _dropDownValue = 'AUD';
  String? _resultText;

  String get resultText => _resultText ?? convertCurrencyText;

  Map get currencyList => _currencyList;

  Map get currencyRatesList => _currencyRatesList;

  String get dropDownValue => _dropDownValue;

  bool get isLoading => _isLoading;

  getCurrencyData() async {
    _isLoading = false;

    _currencyList = await ApiService().fetchCurrency();
    final currencyData = await ApiService().fetchCurrencyRates();
    _currencyRatesList = currencyData!.rates;

    _isLoading = true;
    notifyListeners();
  }

  onSelectedValue(String value) {
    _dropDownValue = value;
    notifyListeners();
  }

  usdToAnyFunc(String value) {
    if (value.isEmpty || value == '') {
      _resultText = convertCurrencyText;

      notifyListeners();
    } else {
      String answer =
          ((_currencyRatesList[_dropDownValue] * double.parse(value))
                  .toStringAsFixed(2))
              .toString();

      _resultText = '$value USD = $answer $_dropDownValue';
      debugPrint(_resultText);
      notifyListeners();

      return answer;
    }
  }

  defaultText() {
    _resultText = convertCurrencyText;
    notifyListeners();
  }
}

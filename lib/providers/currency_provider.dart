import 'package:flutter/material.dart';
import '../apiservices/api_service.dart';
import '../utils/constants.dart';

class CurrencyProvider extends ChangeNotifier {
  bool _isLoading = false;
  Map _currencyList = {};
  Map _currencyList1 = {};
  Map _currencyList2 = {};
  Map _currencyRatesList = {};
  String _dropDownValue = 'AUD';
  String _dropDownValue1 = 'USD';
  String _dropDownValue2 = 'INR';
  String? _usdResultText;
  String? _anyResultText;

  String get usdResultText => _usdResultText ?? convertText;

  String get anyResultText => _anyResultText ?? convertText;

  Map get currencyList => _currencyList;

  Map get currencyList1 => _currencyList1;

  Map get currencyList2 => _currencyList2;

  Map get currencyRatesList => _currencyRatesList;

  String get dropDownValue => _dropDownValue;

  String get dropDownValue1 => _dropDownValue1;

  String get dropDownValue2 => _dropDownValue2;

  bool get isLoading => _isLoading;

  getCurrencyData() async {
    _isLoading = false;

    _currencyList = await ApiService().fetchCurrency();
    final currencyData = await ApiService().fetchCurrencyRates();
    _currencyRatesList = currencyData!.rates;
    _currencyList1 = _currencyList;
    _currencyList2 = _currencyList;

    _isLoading = true;
    notifyListeners();
  }

  onSelectedValue(String value) {
    _dropDownValue = value;
    notifyListeners();
  }

  onSelectedValue1(String value) {
    _dropDownValue1 = value;
    notifyListeners();
  }

  onSelectedValue2(String value) {
    _dropDownValue2 = value;
    notifyListeners();
  }

  usdToAnyFunc(String value) {
    String answer = ((_currencyRatesList[_dropDownValue] * double.parse(value))
            .toStringAsFixed(2))
        .toString();

    _usdResultText = '$value USD = $answer $_dropDownValue';
    debugPrint(_usdResultText);
    notifyListeners();

    return answer;
  }

  anyToAnyFunc(String value) {
    String answer = ((double.parse(value) /
                _currencyRatesList[_dropDownValue1] *
                _currencyRatesList[_dropDownValue2])
            .toStringAsFixed(2))
        .toString();

    _anyResultText = '$value $_dropDownValue1 = $answer $_dropDownValue2';
    debugPrint(_anyResultText);
    notifyListeners();

    return answer;
  }

  swapCurrencies() {
    if (currencyList.containsKey(_dropDownValue1) &&
        currencyList.containsKey(_dropDownValue2) &&
        _currencyRatesList.containsKey(_dropDownValue1) &&
        _currencyRatesList.containsKey(_dropDownValue2)) {
      var tempCurrency1 = _dropDownValue1;
      var rate1 = _currencyRatesList[_dropDownValue1];
      var rate2 = _currencyRatesList[_dropDownValue2];

      _dropDownValue1 = _dropDownValue2;
      _currencyRatesList[_dropDownValue1] = _currencyRatesList[_dropDownValue2];

      _dropDownValue2 = tempCurrency1;
      _currencyRatesList[_dropDownValue2] = rate1;
      _currencyRatesList[_dropDownValue1] = rate2;

      notifyListeners();

      debugPrint('Swapped $_dropDownValue1  with $_dropDownValue2');
    }
  }

  defaultText() {
    _usdResultText = convertText;
    _anyResultText = convertText;
    notifyListeners();
  }
}

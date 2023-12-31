import 'package:currency_converter/providers/currency_provider.dart';
import 'package:flutter/material.dart';

import '../commonwidget/common_widget.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

class UsdToAny extends StatefulWidget {
  final CurrencyProvider currencyProvider;

  const UsdToAny({Key? key, required this.currencyProvider}) : super(key: key);

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  final usdController = TextEditingController();

  @override
  void dispose() {
    usdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.02),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(width * 0.02),
        border: Border.all(color: blackColor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currencyText,
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: height * 0.02),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              controller: usdController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(width * 0.02),
                labelText: usdLableText,
                labelStyle: const TextStyle(color: blackColor),
                border: commonBorder(),
                focusedBorder: commonBorder(),
                enabledBorder: commonBorder(),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    decoration: commonInputDecoration(),
                    value: widget.currencyProvider.dropDownValue,
                    items: widget.currencyProvider.currencyList.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      widget.currencyProvider.onSelectedValue(value!);
                      debugPrint('selected Currency $value');
                    },
                  ),
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                Expanded(child: commonButton(
                  onPressed: () {
                    switch (usdController.text.trim()) {
                      case '':
                        commonSnackBar(context, message1);
                      default:
                        widget.currencyProvider
                            .usdToAnyFunc(usdController.text.trim());
                    }
                  },
                )),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(widget.currencyProvider.usdResultText)
          ],
        ),
      ),
    );
  }
}

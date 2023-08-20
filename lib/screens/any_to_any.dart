import 'package:currency_converter/providers/currency_provider.dart';
import 'package:flutter/material.dart';
import '../commonwidget/common_widget.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

class AnyToAny extends StatefulWidget {
  final CurrencyProvider currencyProvider;

  const AnyToAny({Key? key, required this.currencyProvider}) : super(key: key);

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  final amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
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
              anyCurrencyText,
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: height * 0.02),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              controller: amountController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(width * 0.02),
                labelText: anyLableText,
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
                  child: DropdownButtonFormField<String>(
                    decoration: commonInputDecoration(),
                    value: widget.currencyProvider.dropDownValue1,
                    items: widget.currencyProvider.currencyList1.keys
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
                      widget.currencyProvider.onSelectedValue1(value!);
                      debugPrint('selected Currency 1 $value');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () => widget.currencyProvider.swapCurrencies(),
                    child: const Icon(Icons.swap_horiz_sharp),
                  ),
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: commonInputDecoration(),
                    value: widget.currencyProvider.dropDownValue2,
                    items: widget.currencyProvider.currencyList2.keys
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
                      widget.currencyProvider.onSelectedValue2(value!);
                      debugPrint('selected Currency 2 $value');
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            commonButton(onPressed: () {
              switch (amountController.text.trim()) {
                case '':
                  commonSnackBar(context, message2);
                default:
                  widget.currencyProvider
                      .anyToAnyFunc(amountController.text.trim());
              }
            }),
            SizedBox(
              height: height * 0.02,
            ),
            Text(widget.currencyProvider.anyResultText)
          ],
        ),
      ),
    );
  }
}

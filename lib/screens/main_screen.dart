import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currency_provider.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final usdController = TextEditingController();

  @override
  void dispose() {
    usdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('===BUILD===');
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        usdController.clear();
        context.read<CurrencyProvider>().defaultText();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            appBarTitle,
            style: const TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2),
          ),
          backgroundColor: blackColor,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Consumer<CurrencyProvider>(
              builder: (context, cP, child) {
                return !cP.isLoading
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.02),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(width * 0.02),
                          border: Border.all(color: blackColor),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currencyText,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.02),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              TextFormField(
                                controller: usdController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(width * 0.02),
                                  labelText: lableText,
                                  labelStyle:
                                      const TextStyle(color: blackColor),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.015)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.015)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.015)),
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
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.all(width * 0.02),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                width * 0.015)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                width * 0.015)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                width * 0.015)),
                                      ),
                                      value: cP.dropDownValue,
                                      isExpanded: true,
                                      items: cP.currencyList.keys
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
                                        cP.onSelectedValue(value!);
                                        debugPrint('selected Currency $value');
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.04,
                                  ),
                                  Expanded(
                                      child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: blackColor,
                                        fixedSize: Size(width, height * 0.052),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                width * 0.015))),
                                    child: Text(
                                      buttonName,
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontSize: height * 0.018),
                                    ),
                                    onPressed: () {
                                      cP.usdToAnyFunc(
                                          usdController.text.trim());
                                    },
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(cP.resultText)
                            ],
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:currency_converter/screens/any_to_any.dart';
import 'package:currency_converter/screens/usd_to_any.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currency_provider.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        context.read<CurrencyProvider>().defaultText();
      },
      child: Scaffold(
        backgroundColor: whiteColor,
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
        body: Consumer<CurrencyProvider>(
          builder: (context, cP, child) {
            if (!cP.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  UsdToAny(currencyProvider: cP),
                  AnyToAny(currencyProvider: cP),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

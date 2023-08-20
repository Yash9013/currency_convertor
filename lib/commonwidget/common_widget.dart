import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

OutlineInputBorder commonBorder() {
  return OutlineInputBorder(borderRadius: BorderRadius.circular(8));
}

InputDecoration commonInputDecoration() {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(8),
    border: commonBorder(),
    focusedBorder: commonBorder(),
    enabledBorder: commonBorder(),
  );
}

ElevatedButton commonButton({ required VoidCallback onPressed}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: blackColor,
          fixedSize: const Size(double.maxFinite, 45),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: onPressed,
      child: Text(
        buttonName,
        style: const TextStyle(color: whiteColor, fontSize: 15),
      ));
}

commonSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Text(message,style: const TextStyle(fontSize: 17),),
    ),
  );
}

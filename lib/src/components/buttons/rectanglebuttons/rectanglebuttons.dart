import 'package:anglemeasurment/src/components/styles/textstyles.dart';
import 'package:flutter/material.dart';

Widget kRectangleButtons(
    {String label = '',
    Function()? onPressed,
    Color? backgroundColor = Colors.blue}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Text(
        label,
        style: sfPro(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
      ));
}

import 'package:flutter/material.dart';

Widget kCircularButton({Function()? onPressed, IconData? icon}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        elevation: 7,
        minimumSize: const Size(40, 40),
        shape: const CircleBorder(
            side: BorderSide(style: BorderStyle.solid))),
    child:  Icon(icon),
  );
}

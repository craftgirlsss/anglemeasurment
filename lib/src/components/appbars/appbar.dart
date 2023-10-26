import 'package:anglemeasurment/src/components/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar defaultAppBar(
    {String? title,
    bool? autoImplyLeading = false,
    bool? withActions = false,
    List<Widget>? actions}) {
  return AppBar(
    centerTitle: true,
    leading: autoImplyLeading == true
        ? InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ))
        : null,
    title: Text(
      title ?? '',
      style: sfPro(
          color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    actions: withActions == true ? actions : null,
  );
}

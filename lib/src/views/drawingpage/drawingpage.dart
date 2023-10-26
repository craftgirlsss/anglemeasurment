import 'package:anglemeasurment/src/components/appbars/appbar.dart';
import 'package:flutter/material.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(autoImplyLeading: true, title: "Drawing Page"),
    );
  }
}

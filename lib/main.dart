import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/helpers/networkhandler/networkhandler.dart';
import 'src/views/splashscreen/splash.dart';

Future<void> main() async {
  HttpOverrides.global = CertificateNetwork();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Measurment Tools',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

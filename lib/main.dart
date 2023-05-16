import 'package:ecommerceproject/signin.dart';
import 'package:ecommerceproject/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Splashscreenpage(),
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
}

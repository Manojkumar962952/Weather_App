import 'package:flutter/material.dart';

import 'HomeWeather.dart';

void main() {
  runApp(MyweatherApp());
}

class MyweatherApp extends StatelessWidget {
  const MyweatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: HomeWeather(),
    );
  }
}

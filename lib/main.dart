import 'package:flutter/material.dart';
import 'package:weather_app/home.dart';

void main() {
  runApp(
    MaterialApp(
      home: const Home(cityName: "Morena"),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'JosefinSans'),
    ),
  );
}

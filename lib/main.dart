import 'package:flutter/material.dart';
import 'package:movie_apps/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      home: new HomePage(),

    );
  }
}
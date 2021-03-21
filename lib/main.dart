import 'package:espich_app/constants.dart';
import 'package:espich_app/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Espich App',
      debugShowCheckedModeBanner: false,
      theme: Constants.themeData,
      home: HomePage(),
    );
  }
}

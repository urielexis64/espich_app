import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Espich App',
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.redAccent,
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Poppins',
            ),
      ),
    );
  }
}

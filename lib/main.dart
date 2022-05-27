import 'package:flutter/material.dart';

import 'ui/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Расходы',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: "Lobster",
          textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: const TextStyle(fontFamily: "Lobster", fontSize: 20)),
          appBarTheme: ThemeData.light().appBarTheme.copyWith(
                  titleTextStyle: const TextStyle(
                fontFamily: "Lobster",
                fontSize: 20,
              ))),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

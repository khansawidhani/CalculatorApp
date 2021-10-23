import 'package:calculator/app_theme.dart';
import 'package:calculator/calculator.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator App",
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: Calculator(),
      routes: {
        "/calculator": (context)=>Calculator()
      },
    );
  }
}
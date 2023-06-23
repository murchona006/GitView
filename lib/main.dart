import 'package:flutter/material.dart';
import '../Screens/homepage2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GitHub App',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: UserProfileHomePage(),

    );

  }
}

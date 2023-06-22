import 'package:flutter/material.dart';
import 'package:inilabs_project/utils/user_provider.dart';
import 'package:provider/provider.dart';
import '../Screens/homepage2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GitHub App',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: UserProfileHomePage(),

    ),
    );
  }
}

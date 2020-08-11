import 'package:flutter/material.dart';
import 'package:contact_list_demo/ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Boilerplate',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light
      ),
      home: HomePage(title: 'Home Page'),
      routes: <String, WidgetBuilder> {
        'Home': (BuildContext context) => HomePage(title: 'Home Page'),
      },
    );
  }
}


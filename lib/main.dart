import 'package:flutter/material.dart';
import 'package:contact_list_demo/ui/home_page.dart';
import 'package:contact_list_demo/ui/add_contact_page.dart';
import 'package:contact_list_demo/ui/edit_contact_page.dart';
import 'package:contact_list_demo/ui/view_contact_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light
      ),
      home: HomePage(title: 'Home Page'),
      routes: <String, WidgetBuilder> {
        'Home': (BuildContext context) => HomePage(title: 'Home Page'),
        'AddContact': (BuildContext context) => AddContactPage(title: 'Add Contact'),
        'EditContact': (BuildContext context) => EditContactPage(title: 'Edit Contact'),
        'ViewContact': (BuildContext context) => ViewContactPage(title: 'View Contact'),
      },
    );
  }
}


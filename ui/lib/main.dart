import 'package:ch13_01/addApp.dart';
import 'package:flutter/material.dart';
import 'firebaseApp.dart';
import 'addApp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FB ex',
      theme: ThemeData(primaryColor: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => FirebaseApp(),
        '/add': (context) => AddApp(),
      },
    );
  }
}

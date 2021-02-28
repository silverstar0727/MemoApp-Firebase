import 'package:flutter/material.dart';

class FirebaseApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirebaseApp();
  }
}

class _FirebaseApp extends State<FirebaseApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FB ex Main'),
      ),
      body: Container(child: Center(child: Text('FBA'))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/add');
        },
      ),
    );
  }
}

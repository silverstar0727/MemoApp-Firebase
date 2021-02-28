import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Edit();
  }
}

class _Edit extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 수정'),
      ),
      body: Container(child: Center(child: Text('메모 수정'))),
    );
  }
}

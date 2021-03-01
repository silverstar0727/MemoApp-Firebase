import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'memo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'dart:io';


class AddApp1 extends StatefulWidget {
  AddApp1(this.reference);

  final DatabaseReference reference;

  @override
  State<StatefulWidget> createState() {
    return _AddApp1();
  }
}

class _AddApp1 extends State<AddApp1> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: TextField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'title',
                      fillColor: Colors.blueAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: TextField(
                  controller: contentController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'content'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: FlatButton(
                  onPressed: () {
                    widget.reference
                        .push()
                        .set(Memo(
                        titleController.value.text,
                        contentController.value.text,
                        DateTime.now().toIso8601String())
                        .toJson())
                        .then((_) => {
                          Navigator.of(context).pop()
                    });
                  },
                  child: Text('저장하기'),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

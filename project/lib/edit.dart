import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'memo.dart';
import 'package:firebase_database/firebase_database.dart';

class Edit extends StatefulWidget {
  Edit(this.reference, this.memo);

  final DatabaseReference reference;
  final Memo memo;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Edit();
  }
}

class _Edit extends State<Edit> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.memo.title);
    contentController = TextEditingController(text: widget.memo.content);
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memo.title),
      ),
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
                    Memo memo = Memo(titleController.value.text, contentController.value.text, widget.memo.createTime);
                    widget.reference
                        .child(widget.memo.key)
                        .set(memo.toJson())
                        .then((_){ Navigator.of(context).pop(memo);
                        });
                  },
                  child: Text('수정하기'),
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

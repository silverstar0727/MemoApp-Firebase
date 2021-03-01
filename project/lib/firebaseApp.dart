import 'package:flutter/material.dart';
import 'memo.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'edit.dart';

class FirebaseApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<StatefulWidget> createState() {
    return _FirebaseApp(analytics, observer);
  }
}

class _FirebaseApp extends State<FirebaseApp> {
  _FirebaseApp(this.analytics, this.observer);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  FirebaseDatabase _database;
  DatabaseReference reference;
  String _databaseURL = 'https://ch13-1-default-rtdb.firebaseio.com/';

  List<Memo> memos = List();

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database.reference().child('memo');

    reference.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FB ex Main'),
      ),
      body: Container(
        child: Center(
          child: memos.length == 0
          ? CircularProgressIndicator()
          : GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (content, index) {
              return Card(
                child: GridTile(
                  child: Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(
                      child: GestureDetector(
                        onTap: () async{
                          Memo memo = await Navigator.of(context).push(
                              MaterialPageRoute<Memo>(
                                  builder: (BuildContext context) =>
                                      Edit(reference, memos[index])));
                          if(memo != null){
                            setState(() {
                              memos[index].title = memo.title;
                              memos[index].content = memo.content;
                            });
                          }
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(memos[index].title),
                                  content: Text('삭제하시겠습니까?'),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: (){
                                          reference
                                              .child(memos[index].key)
                                              .remove()
                                              .then((_) {
                                                setState(() {
                                                  memos.removeAt(index);
                                                }
                                                );});
                                          Navigator.pop(context);
                                        },
                                        child: Text('예')),
                                    FlatButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text('아니오'))
                                  ],
                                );
                              });
                        },
                        child: Text(memos[index].content),
                      ),
                    ),
                  ),
                  header: Text(
                    'Title: ${memos[index].title}',
                    style: TextStyle(color: Colors.blue),
                  ),
                  footer: Text(
                    memos[index].createTime.substring(0, 10),
                  ),
                ),
              );
            },
            itemCount: memos.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            Navigator.of(context).pushNamed('/add', arguments: reference);
          });
        },
      ),
    );
  }
}
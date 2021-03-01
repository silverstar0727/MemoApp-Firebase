import 'package:flutter/material.dart';
import 'memo.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';

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
                        onTap: () {
                          Navigator.of(context).pushNamed('/edit');
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('sdf'),
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
          Navigator.of(context).pushNamed('/add');
        },
      ),
    );
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'test',
      parameters: <String, dynamic>{
        'string': 'hello flutter',
        'int': 100,
      },
    );
    print('성공');
  }
}
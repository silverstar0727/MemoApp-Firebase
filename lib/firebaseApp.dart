import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'tabPage.dart';

class FirebaseApp extends StatefulWidget {
  FirebaseApp({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FirebaseApp(analytics, observer);
  }
}

class _FirebaseApp extends State<FirebaseApp> {
  _FirebaseApp(this.analytics, this.observer);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Test'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(onPressed: _sendAnalyticsEvent, child: Text('테스트')),
            Text(
              _message,
              style: TextStyle(fontSize: 20, color: Colors.blue),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<TabPage>(
              settings: RouteSettings(name: '/tab'),
              builder: (BuildContext context) {
                return TabPage(observer);
              }));
        },
      ),
    );
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'test event',
      parameters: <String, dynamic>{'string': 'hello flutter', 'int': 100},
    );
    setState(() {
      _message = 'Analytics 보내기 성공';
    });
  }
}

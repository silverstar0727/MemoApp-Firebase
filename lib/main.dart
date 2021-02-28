import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebaseApp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'FB ex',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: FirebaseApp(analytics: analytics, observer: observer,),
    );
  }
}
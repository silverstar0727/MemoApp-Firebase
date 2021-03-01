import 'package:flutter/material.dart';
import 'addApp_tab1.dart';
import 'addApp_tab2.dart';
import 'package:firebase_database/firebase_database.dart';

class AddApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddApp();
  }
}

class _AddApp extends State<AddApp> with SingleTickerProviderStateMixin {
  TabController tab_ctr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tab_ctr = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseReference reference = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('AddMemo'),
        bottom: TabBar(
          controller: tab_ctr,
          tabs: <Tab>[
            Tab(
              text: 'ADD!!',
            ),
            Tab(
              text: 'TEMP',
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[AddApp1(reference), AddApp2()],
        controller: tab_ctr,
      ),
    );
  }
}

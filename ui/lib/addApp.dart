import 'package:flutter/material.dart';
import 'addApp_tab1.dart';
import 'addApp_tab2.dart';

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
        children: <Widget>[AddApp1(), AddApp2()],
        controller: tab_ctr,
      ),
    );
  }
}

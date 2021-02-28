import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';

class TabPage extends StatefulWidget {
  TabPage(this.observer);
  final FirebaseAnalyticsObserver observer;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabPage(observer);
  }
}

class _TabPage extends State<TabPage>
    with SingleTickerProviderStateMixin, RouteAware {
  _TabPage(this.observer);

  TabController tab_ctr;
  FirebaseAnalyticsObserver observer;
  int selectedIndex = 0;

  final List<Tab> tabs = <Tab>[
    Tab(
      text: '1번',
      icon: Icon(Icons.looks_one),
    ),
    Tab(
      text: '2번',
      icon: Icon(Icons.looks_two),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tab_ctr = TabController(
        length: tabs.length, vsync: this, initialIndex: selectedIndex);
    tab_ctr.addListener(() {
      setState(() {
        if (selectedIndex != tab_ctr.index) {
          selectedIndex = tab_ctr.index;
          observer.analytics.setCurrentScreen(screenName: 'tab/$selectedIndex');
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    observer.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    observer.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(controller: tab_ctr, tabs: tabs),
      ),
      body: TabBarView(
        children: tabs.map((Tab tab) {
          return Center(
            child: Text(tab.text),
          );
        }).toList(),
        controller: tab_ctr,
      ),
    );
  }
}

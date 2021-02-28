import 'package:flutter/material.dart';
import 'memo.dart';

class FirebaseApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirebaseApp();
  }
}

class _FirebaseApp extends State<FirebaseApp> {
  List<Memo> memos = List();

  @override
  void initState() {
    super.initState();
    setState(() {
      memos.add(Memo('sdf', 'asdf', '2021-3-1'));
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
          child: GridView.builder(
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
                    memos[index].createTime,
                  ),
                ),
              );
            },
            itemCount: 1,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/add');
        },
      ),
    );
  }
}

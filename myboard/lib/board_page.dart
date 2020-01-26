import 'package:flutter/material.dart';

import 'model.dart';

const mockJson = '''
{"id":"1","name":"sample board","items":[
  {"name":"item0","status":"Done"},
  {"name":"item1","status":"Done"},
  {"name":"item2","status":"Done"},
  {"name":"item3","status":"Done"},
  {"name":"item4","status":"Done"},
  {"name":"item5","status":"Ontime"},
  {"name":"item6","status":"Ontime"},
  {"name":"item7","status":"Ontime"},
  {"name":"item8","status":"Ontime"},
  {"name":"item9","status":"Ontime"},
  {"name":"item10","status":"Delay"},
  {"name":"item11","status":"Delay"},
  {"name":"item12","status":"Delay"},
  {"name":"item13","status":"Delay"},
  {"name":"item14","status":"Delay"},
  {"name":"item15","status":"Stop"},
  {"name":"item16","status":"Stop"},
  {"name":"item17","status":"Stop"},
  {"name":"item18","status":"Stop"},
  {"name":"item19","status":"Stop"},
  {"name":"item20","status":"-"},
  {"name":"item21","status":"-"},
  {"name":"item22","status":"-"},
  {"name":"item23","status":"-"},
  {"name":"item24","status":"-"}
]}
''';

var board = Board.fromJsonString(mockJson);

extension BoardItemWidget on BoardItem {
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'done':
        return Colors.green;
      case 'ontime':
        return Colors.blue;
      case 'delay':
        return Colors.orange;
      case 'stop':
        return Colors.red;
    }
    return Colors.black;
  }

  Widget get w {
    return ListTile(
      title: Text(name),
      trailing: Text(status, style: TextStyle(color: statusColor)),
      leading: CircleAvatar(backgroundColor: statusColor),
    );
  }
}

extension BoardWidget on Board {
  Widget widget() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          flexibleSpace: FlexibleSpaceBar(title: Text(name)),
          expandedHeight: 200,
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(items.map((i) => i.w).toList()),
        )
        // ...items.map((i) => i.w).toList(),
      ],
    );
  }
}

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: board.widget(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:dart_nats/dart_nats.dart' as nats;
import 'model.dart';

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
  var client = nats.Client();
  nats.Subscription sub;

  @override
  void initState() {
    super.initState();
    client.connect('10.0.2.2');
    sub = client.sub('byBoard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: sub.stream,
        builder: (c, AsyncSnapshot<nats.Message> snapshot) {
          if (!snapshot.hasData) {
            return Text('NO data');
          }
          return Board.fromJsonString(snapshot.data.string).widget();
        },
      ),
    );
  }

  @override
  void dispose() {
    sub.unSub();
    client.close();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:myboard/model.dart';
import 'package:dart_nats/dart_nats.dart' as nats;

extension BoardItemWidget on BoardItem {
  Color get color {
    switch (status) {
      case 'Done':
        return Colors.green;
      case 'Ontime':
        return Colors.blue;
      case 'Delay':
        return Colors.orange;
      case 'Stop':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Widget get w {
    return ListTile(
      title: Text(
        this.name,
      ),
      trailing: Text(this.status, style: TextStyle(color: color)),
      leading: CircleAvatar(
        backgroundColor: color,
      ),
    );
  }
}

extension BoardWidget on Board {
  Widget widget() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          flexibleSpace: FlexibleSpaceBar(
            title: Text(name),
          ),
          pinned: true,
          expandedHeight: 100,
        ),
        SliverList(
          delegate: SliverChildListDelegate(items.map((i) => i.w).toList()),
        ),
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
    sub = client.sub('mockboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: sub.stream,
        builder: (context, AsyncSnapshot<nats.Message> snapshot) {
          if (!snapshot.hasData) {
            return Text('nodata');
          }
          var board = Board.fromJsonString(snapshot.data.string);
          return board.widget();
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

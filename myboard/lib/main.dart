import 'dart:async';

import 'package:flutter/material.dart';
import 'board_page.dart';
import 'home_page.dart';
import 'package:dart_nats/dart_nats.dart' as nats;

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

void main() async {
  var board = Board.fromJsonString(mockJson);

  var server = nats.Client();
  await server.connect('10.0.2.2');
  Timer.periodic(Duration(seconds: 5), (t) {
    server.pubString('mockboard', board.toJsonString());
    print(board.toJsonString());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoardPage(),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'board_page.dart';
import 'home_page.dart';
import 'package:dart_nats/dart_nats.dart' as nats;

import 'model.dart';

Board mockBoard() {
  Board b;
  b = Board.fromJsonString('{"id":"1","name":"sample board","items":[]}');
  int n = 0;
  for (var i = 0; i < 5; i++, n++) {
    b.items.add(BoardItem.fromJsonString('{"name":"item$n","status":"Done"}'));
  }
  for (var i = 0; i < 5; i++, n++) {
    b.items
        .add(BoardItem.fromJsonString('{"name":"item$n","status":"Ontime"}'));
  }
  for (var i = 0; i < 5; i++, n++) {
    b.items.add(BoardItem.fromJsonString('{"name":"item$n","status":"Delay"}'));
  }
  for (var i = 0; i < 5; i++, n++) {
    b.items.add(BoardItem.fromJsonString('{"name":"item$n","status":"Stop"}'));
  }
  for (var i = 0; i < 5; i++, n++) {
    b.items.add(BoardItem.fromJsonString('{"name":"item$n","status":"-"}'));
  }

  return b;
}

void main() async {
  var board = mockBoard();

  var server = nats.Client();
  await server.connect('10.0.2.2');
  Timer.periodic(Duration(seconds: 5), (t) {
    server.pubString('mockboard', board.toJsonString());
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

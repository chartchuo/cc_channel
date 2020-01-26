import 'dart:convert';

import 'package:dart_nats/dart_nats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myboard/model.dart';

main() {
  group('nats', () {
    test('connect', () async {
      var client = Client();
      await client.connect('localhost');
      var sub = client.sub('sub');
      var r = 0;
      var iteration = 100;
      sub.stream.listen((msg) {
        print(msg.string);
        r++;
      });
      for (var i = 0; i < iteration; i++) {
        client.pubString('sub', i.toString());
        await Future.delayed(Duration(milliseconds: 10));
      }
      await Future.delayed(Duration(seconds: 1));
      client.close();
      expect(r, equals(iteration));
    });
    test('send model', () async {
      var jsonString = '{"id":"123","items":[{"name":"nnn","status":"sss"}]}';
      var sendBoard = Board.fromJson(jsonDecode(jsonString));
      var client = Client();
      await client.connect('localhost');
      var sub = client.sub('MyBoard.board');

      client.pubString('MyBoard.board', jsonEncode(sendBoard.toJson()));

      var msg = await sub.stream.first;
      var receiveBoard = Board.fromJson(jsonDecode(msg.string));
      client.close();
      expect(receiveBoard.toJson(), equals(sendBoard.toJson()));
    });
    test('send model string', () async {
      var jsonString = '{"id":"123","items":[{"name":"nnn","status":"sss"}]}';
      var sendBoard = Board.fromJsonString(jsonString);
      var client = Client();
      await client.connect('localhost');
      var sub = client.sub('MyBoard.board');

      client.pubString('MyBoard.board', sendBoard.toJsonString());

      var msg = await sub.stream.first;
      var receiveBoard = Board.fromJsonString(msg.string);
      client.close();
      expect(receiveBoard.toJson(), equals(sendBoard.toJson()));
    });
  });
}

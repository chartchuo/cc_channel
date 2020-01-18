import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:myboard/model.dart';

void main() {
  group('model', () {
    test('json', () {
      var str = '{"id":"123","items":[{"name":"nnn","status":"sss"}]}';
      var board = Board.fromJson(jsonDecode(str));
      print(jsonEncode(board.toJson()));
      expect(board.toJson(), equals(jsonDecode(str)));
    });
  });
}

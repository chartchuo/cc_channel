import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Board {
  String id;
  String name;
  List<BoardItem> items;
  Board();

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
  Map<String, dynamic> toJson() => _$BoardToJson(this);
  factory Board.fromJsonString(String str) => _$BoardFromJson(jsonDecode(str));
  String toJsonString() => jsonEncode(toJson());
}

@JsonSerializable()
class BoardItem {
  String name;
  String status;
  BoardItem();

  factory BoardItem.fromJson(Map<String, dynamic> json) =>
      _$BoardItemFromJson(json);
  Map<String, dynamic> toJson() => _$BoardItemToJson(this);
  factory BoardItem.fromJsonString(String str) =>
      _$BoardItemFromJson(jsonDecode(str));
  String toJsonString() => jsonEncode(toJson());
}

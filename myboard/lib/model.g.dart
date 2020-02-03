// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) {
  return Board()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : BoardItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..lastUpdate = json['lastUpdate'] == null
        ? null
        : DateTime.parse(json['lastUpdate'] as String);
}

Map<String, dynamic> _$BoardToJson(Board instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('items', instance.items?.map((e) => e?.toJson())?.toList());
  writeNotNull('lastUpdate', instance.lastUpdate?.toIso8601String());
  return val;
}

BoardItem _$BoardItemFromJson(Map<String, dynamic> json) {
  return BoardItem()
    ..name = json['name'] as String
    ..status = json['status'] as String;
}

Map<String, dynamic> _$BoardItemToJson(BoardItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('status', instance.status);
  return val;
}

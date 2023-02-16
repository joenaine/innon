// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      title: json['title'] as String,
      cards: (json['cards'] as List<dynamic>)
          .map((e) => BoardCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      index: json['index'] as int,
      backgroundIndex: json['backgroundIndex'] as int? ?? 0,
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'title': instance.title,
      'cards': instance.cards,
      'index': instance.index,
      'backgroundIndex': instance.backgroundIndex,
    };

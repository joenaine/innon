// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardCard _$BoardCardFromJson(Map<String, dynamic> json) => BoardCard(
      title: json['title'] as String,
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BoardCardToJson(BoardCard instance) => <String, dynamic>{
      'tasks': instance.tasks,
      'title': instance.title,
    };

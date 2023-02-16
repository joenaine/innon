// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relation _$RelationFromJson(Map<String, dynamic> json) => Relation(
      from: json['from'] as int,
      task: Task.fromJson(json['task'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RelationToJson(Relation instance) => <String, dynamic>{
      'task': instance.task,
      'from': instance.from,
    };

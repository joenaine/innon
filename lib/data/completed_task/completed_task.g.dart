// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedTask _$CompletedTaskFromJson(Map<String, dynamic> json) =>
    CompletedTask(
      title: json['title'] as String,
      completionDate: DateTime.parse(json['completionDate'] as String),
      timeSpent: json['timeSpent'] as String,
    );

Map<String, dynamic> _$CompletedTaskToJson(CompletedTask instance) =>
    <String, dynamic>{
      'title': instance.title,
      'completionDate': instance.completionDate.toIso8601String(),
      'timeSpent': instance.timeSpent,
    };

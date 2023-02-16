// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_tasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedTasks _$CompletedTasksFromJson(Map<String, dynamic> json) =>
    CompletedTasks(
      completedTasks: (json['completedTasks'] as List<dynamic>?)
          ?.map((e) => CompletedTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompletedTasksToJson(CompletedTasks instance) =>
    <String, dynamic>{
      'completedTasks': instance.completedTasks,
    };

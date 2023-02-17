// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      countDown: json['countDown'] as int? ?? 0,
      dateTimeEntry: json['dateTimeEntry'] == null
          ? null
          : DateTime.parse(json['dateTimeEntry'] as String),
      isTimerRunning: json['isTimerRunning'] as bool? ?? false,
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'countDown': instance.countDown,
      'dateTimeEntry': instance.dateTimeEntry?.toIso8601String(),
      'isTimerRunning': instance.isTimerRunning,
      'users': instance.users,
    };

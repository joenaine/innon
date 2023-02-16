import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innon/data/completed_task/completed_task.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../services/types.dart';
part 'completed_tasks.g.dart';

@JsonSerializable()
class CompletedTasks {
  List<CompletedTask>? completedTasks;

  CompletedTasks({this.completedTasks});
  factory CompletedTasks.fromJson(Map<String, dynamic> json) =>
      _$CompletedTasksFromJson(json);

  Map<String, dynamic> toJson() => _$CompletedTasksToJson(this);

  factory CompletedTasks.fromFirestore(DocumentSnapshot<Json> doc) {
    return CompletedTasks.fromJson(doc.data() ?? {});
  }
}

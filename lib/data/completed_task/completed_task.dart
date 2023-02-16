import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../services/types.dart';
part 'completed_task.g.dart';

@JsonSerializable()
class CompletedTask {
  String title;

  DateTime completionDate;

  String timeSpent;

  CompletedTask({
    required this.title,
    required this.completionDate,
    required this.timeSpent,
  });
  factory CompletedTask.fromJson(Map<String, dynamic> json) =>
      _$CompletedTaskFromJson(json);

  Map<String, dynamic> toJson() => _$CompletedTaskToJson(this);

  factory CompletedTask.fromFirestore(DocumentSnapshot<Json> doc) {
    return CompletedTask.fromJson(doc.data() ?? {});
  }
}

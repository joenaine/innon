import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innon/data/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../services/types.dart';
part 'task.g.dart';

@JsonSerializable()
class Task {
  String title;

  String description;

  int countDown;

  DateTime? dateTimeEntry;

  bool isTimerRunning;

  List<UserModel>? users;

  Task(
      {required this.title,
      this.description = '',
      this.countDown = 0,
      this.dateTimeEntry,
      this.isTimerRunning = false,
      this.users});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  factory Task.fromFirestore(DocumentSnapshot<Json> doc) {
    return Task.fromJson(doc.data() ?? {});
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/types.dart';
import '../task/task.dart';
import 'package:json_annotation/json_annotation.dart';
part 'relation.g.dart';

@JsonSerializable()
class Relation {
  Task task;

  int from;

  Relation({
    required this.from,
    required this.task,
  });

  factory Relation.fromJson(Map<String, dynamic> json) =>
      _$RelationFromJson(json);

  Map<String, dynamic> toJson() => _$RelationToJson(this);

  factory Relation.fromFirestore(DocumentSnapshot<Json> doc) {
    return Relation.fromJson(doc.data() ?? {});
  }
}

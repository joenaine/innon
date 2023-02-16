import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/types.dart';
import '../task/task.dart';
import 'package:json_annotation/json_annotation.dart';
part 'card.g.dart';

@JsonSerializable()
class BoardCard {
  List<Task> tasks;

  String title;

  BoardCard({
    required this.title,
    required this.tasks,
  });

  factory BoardCard.fromJson(Map<String, dynamic> json) =>
      _$BoardCardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardCardToJson(this);

  factory BoardCard.fromFirestore(DocumentSnapshot<Json> doc) {
    return BoardCard.fromJson(doc.data() ?? {});
  }
}

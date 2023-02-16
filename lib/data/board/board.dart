import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/types.dart';
import '../card/card.dart';
import 'package:json_annotation/json_annotation.dart';
part 'board.g.dart';

@JsonSerializable()
class Board {
  final String title;

  final List<BoardCard> cards;

  final int index;

  final int backgroundIndex;

  Board({
    required this.title,
    required this.cards,
    required this.index,
    this.backgroundIndex = 0,
  });
  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardToJson(this);

  factory Board.fromFirestore(DocumentSnapshot<Json> doc) {
    return Board.fromJson(doc.data() ?? {});
  }
}

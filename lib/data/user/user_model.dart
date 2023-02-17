import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innon/services/timestamp_converter.dart';
import 'package:innon/services/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? id;
  final String? username;
  final String? email;
  final String? photo;
  final String? token;
  final String? password;
  @TimestampConverter()
  final DateTime? createdAt;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.photo,
      this.password,
      this.createdAt,
      this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromFirestore(DocumentSnapshot<Json> doc) {
    return UserModel.fromJson(doc.data() ?? {});
  }
}

import 'dart:convert';

class ScoreModel {
  final String? uid;
  final int? value;

  ScoreModel({
    this.uid,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'value': value,
    };
  }

  factory ScoreModel.fromMap(Map<String, dynamic> map) {
    return ScoreModel(
      uid: map['uid'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoreModel.fromJson(String source) =>
      ScoreModel.fromMap(json.decode(source));
}

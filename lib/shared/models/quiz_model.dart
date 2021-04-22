import 'dart:convert';

import 'package:quiz/shared/models/question_model.dart';

enum Level { facil, medio, dificil, perito }

extension LevelStringExtension on String {
  Level get parse => {
        'facil': Level.facil,
        'medio': Level.medio,
        'dificil': Level.dificil,
        'perito': Level.perito,
      }[this]!;
}

extension LevelExtension on Level {
  String get parse => {
        Level.facil: 'facil',
        Level.medio: 'medio',
        Level.dificil: 'dificil',
        Level.perito: 'perito',
      }[this]!;
}

class QuizModel {
  final String title;
  final int quantityAnswered;
  final String image;
  final Level level;
  final List<QuestionModel> questions;

  QuizModel({
    required this.title,
    this.quantityAnswered = 0,
    required this.image,
    required this.level,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'quantityAnswered': quantityAnswered,
      'image': image,
      'level': level.parse,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      title: map['title'],
      quantityAnswered: map['quantityAnswered'],
      image: map['image'],
      level: map['level'].toString().parse,
      questions: List<QuestionModel>.from(
          map['questions']?.map((x) => QuestionModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
